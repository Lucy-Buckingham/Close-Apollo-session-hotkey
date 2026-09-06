# Close Apollo session hotkey

Press **Ctrl+Alt+Shift+F12** on the host keyboard to close the active Apollo streaming session. This is useful when you forget to end a Moonlight session and the host displays remain disabled.

> **Save your game first.** This can close a game or launcher managed by Apollo, not just disconnect Moonlight.

## Requirements

- Windows with Apollo running and Moonlight streaming configured.
- [AutoHotkey v2](https://www.autohotkey.com/).
- Windows PowerShell 5.1 and `curl.exe`.

The PowerShell script uses Apollo’s cookie-based Web UI API.

## Setup

1. Copy [Close-ApolloSession.ps1](Close-ApolloSession.ps1) and [ApolloHotkeys.ahk](ApolloHotkeys.ahk) from this repository to `C:\Scripts`.
2. Edit `Close-ApolloSession.ps1`. Set `$ApolloUsername` and `$ApolloPassword` to your Apollo Web UI credentials. Change the local port in `$ApolloUrl` only if needed.
3. With a stream running, test the script from PowerShell:

   `powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Scripts\Close-ApolloSession.ps1"`

4. Confirm that the session ends and the displays return to their expected state.
5. Double-click `ApolloHotkeys.ahk`. The keyboard shortcut is now active.

If you use another folder, update the script path in `ApolloHotkeys.ahk`.

## Start with Windows

1. Press **Win+R**, enter `shell:startup`, then press Enter.
2. Add a shortcut to `C:\Scripts\ApolloHotkeys.ahk` in that folder.

The hotkey script will start when you sign in.

## Notes

- **Never commit your configured password to GitHub.** Keep configured scripts outside the repository. The password is stored as plain text.
- Keep the API address on `https://localhost`. The script skips certificate validation for these local requests.
- The host must be awake, signed in, and on the normal desktop. The shortcut does not bypass the lock screen.
- Input forwarded through Moonlight can also trigger the shortcut.
- Running the script can sign your Apollo Web UI browser session out.
- If the shortcut fails, run the PowerShell test above to see the error.
