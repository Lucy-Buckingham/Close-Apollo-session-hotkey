$ErrorActionPreference = 'Stop'

$ApolloUsername = 'YOUR_APOLLO_USERNAME'
$ApolloPassword = 'YOUR_APOLLO_PASSWORD'
$ApolloUrl = 'https://localhost:47990'

$CookieFile = [IO.Path]::GetTempFileName()
$PreviousEncoding = $OutputEncoding

# Certificate checking is disabled only for these local requests.
$CurlOptions = @(
    '--disable'
    '--silent'
    '--show-error'
    '--fail'
    '--insecure'
    '--noproxy', '*'
    '--connect-timeout', '5'
    '--max-time', '15'
)

try {
    $OutputEncoding = [System.Text.UTF8Encoding]::new($false)

    $LoginBody = @{
        username = $ApolloUsername
        password = $ApolloPassword
    } | ConvertTo-Json -Compress

    # Send credentials through stdin, not command-line arguments.
    $LoginBody | & curl.exe @CurlOptions `
        --request POST `
        --header 'Content-Type: application/json' `
        --cookie-jar $CookieFile `
        --data-binary '@-' `
        "$ApolloUrl/api/login"

    if ($LASTEXITCODE -ne 0) {
        throw 'Apollo login failed. Check the error shown above.'
    }

    $Reply = & curl.exe @CurlOptions `
        --request POST `
        --header 'Content-Type: application/json' `
        --cookie $CookieFile `
        --data '{}' `
        "$ApolloUrl/api/apps/close"

    if ($LASTEXITCODE -ne 0) {
        throw 'The Apollo close request failed.'
    }

    $Result = $Reply | ConvertFrom-Json
    if ($Result.status -ne $true) {
        throw 'Apollo did not confirm the close request.'
    }

    Write-Host 'Apollo accepted the close request.'
}
finally {
    $OutputEncoding = $PreviousEncoding
    Remove-Item -LiteralPath $CookieFile -Force -ErrorAction SilentlyContinue
}