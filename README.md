# Safe-Windows

One-key PowerShell to check if your Windows is safe to use.

## How to run

First, search `PowerShell` in Windows search. Then click `Run as administrator`.

![open-powershell-admin](assets/open-powershell-admin.png)

Then copy the following command and paste it into the PowerShell window. Then press `Enter`.

```powershell
Remove-Item "$env:TEMP\safe-windows-master\" -Recurse -ErrorAction SilentlyContinue; $destinationPath = "$env:TEMP\safe-windows-master.zip"; Invoke-WebRequest -Uri "https://gitlab.aiursoft.cn/aiursoft/safe-windows/-/archive/master/safe-windows-master.zip" -OutFile $destinationPath -UseBasicParsing; Expand-Archive -Path $destinationPath -DestinationPath $env:TEMP; Remove-Item $destinationPath; Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force; . "$env:TEMP\safe-windows-master\Run.ps1"
```

And then you will see the output like this:

![run](./assets/sample-run.png)

It will show you suggestions to make your Windows safer.
