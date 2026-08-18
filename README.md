# VLC-Fix
Fix slow opening VLC due to Windows defender
- Open Command Prompt as an administrator and run:

`"C:\Program Files\VideoLAN\VLC\vlc-cache-gen.exe" "C:\Program Files\VideoLAN\VLC\plugins"`

- Or force a reset via the executable:

`"C:\Program Files\VideoLAN\VLC\vlc.exe" --reset-plugins-cache vlc://quit`

Optionally [download](https://raw.githubusercontent.com/Pacmanninja/VLC-Fix/refs/heads/main/vlc_fix.bat "download") and run the batch file tool to find VLC and reset the cache that way.
