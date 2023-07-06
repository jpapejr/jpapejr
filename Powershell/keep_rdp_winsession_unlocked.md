When you're working on a remote box via RDP and it's configured to lock the screen after a period of time you 
can attempt to fool this mechanism by telling PowerShell to execute keystrokes to fooll the OS into thinking 
there is activity going on. 


Open this a Powershell window and execute this line
```
$WShell = New-Object -Com Wscript.Shell; while (1) {$WShell.SendKeys("{SCROLLLOCK}"); sleep 60}
```

This script sends a Scroll Lock key input to a new, hidden shell object every 60 seconds. 
