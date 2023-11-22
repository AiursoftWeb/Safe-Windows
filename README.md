# Safe-Windows

One-key PowerShell to check if your Windows is safe to use.

## How to run

```powershell
Remove-Item "$env:TEMP\safe-windows-master\" -Recurse -ErrorAction SilentlyContinue; $destinationPath = "$env:TEMP\safe-windows-master.zip"; Invoke-WebRequest -Uri "https://gitlab.aiursoft.cn/anduin/safe-windows/-/archive/master/safe-windows-master.zip" -OutFile $destinationPath -UseBasicParsing; Expand-Archive -Path $destinationPath -DestinationPath $env:TEMP; Remove-Item $destinationPath; Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force; . "$env:TEMP\safe-windows-master\Run.ps1"
```
