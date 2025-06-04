---
title: "KB5051987 causes Windows 11 RDP session to get stuck at login if user account already logged in - Microsoft Q&A"
source: "https://learn.microsoft.com/en-us/answers/questions/2169684/kb5051987-causes-windows-11-rdp-session-to-get-stu"
author:
published:
created: 2025-03-04
description: "Hi,KB5051987 causes Windows 11 RDP session to get stuck at login if user account already logged in.The session connects &amp; freezes with the desktop background.If you disconnect the user, you can then RDP in with that user.I uninstalled the…"
tags:
  - "clippings"


---
Hi,

KB5051987 causes Windows 11 RDP session to get stuck at login if user account already logged in.

The session connects & freezes with the desktop background.

If you disconnect the user, you can then RDP in with that user.

I uninstalled the KB5051987 update & this resolved the problem.

## 3 answers

1. - Run gpedit.msc
- Use the following path to get to the "*Connections*" folder **Local Computer Policy> Computer Configuration > Administrative Templates > Windows Components > Remote Desktop Services > Remote Desktop Session Host > Connections**
- From within the Connections folder, in the right pane, locate and double-click on "**Select network detection on the server**".
- Change the State to **ENABLED**
- Under **Options:**, change the **Select Network Detect Level**  drop-down to "**Turn off Connect Time Detect and Continuous Network Detect**".  Should be the last option in the list (screenshot below).  Click Apply --> OK
- Close Group Policy Editor.  Open an elevated Command Prompt, type **gpupdate /force**
- Once gpupdate completes, close command prompt and test Remote Desktop again.  No reboot necessary.

![User's image](https://learn-attachment.microsoft.com/api/attachments/80a31703-fb84-4b8a-adfe-1f8a0885afea?platform=QnA)
2. ![](https://learn.microsoft.com/en-us/answers/questions/2169684/www.w3.org/2000/svg'%20height='64'%20class='font-weight-bold'%20style='font:%20600%2030.11764705882353px%20%22SegoeUI%22,%20Arial'%20width='64'%3E%3Ccircle%20fill='hsl(217.60000000000002,%2017%,%2031%)'%20cx='32'%20cy='32'%20r='32'%20/%3E%3Ctext%20x='50%25'%20y='55%25'%20dominant-baseline='middle'%20text-anchor='middle'%20fill='%23FFF'%20%3EZH%3C/text%3E%3C/svg%3E)

[Zunhui Han](https://learn.microsoft.com/en-us/users/na/?userid=c68b1a7e-3649-4e6d-a7a0-52fce3aaed5d) 3,410 Reputation points Microsoft External Staff

Feb 19, 2025 at 11:06 AM

[Sign in to answer](https://learn.microsoft.com/en-us/answers/questions/2169684/#)

## Your answer

Answers can be marked as Accepted Answers by the question author, which helps users to know the answer solved the author's problem.

### Question activity

### Additional resources

---

Documentation

- [SBSL issue when you create an RDP connection to Windows Server 2012 R2 - Windows Server](https://learn.microsoft.com/en-us/troubleshoot/windows-server/performance/sbsl-issue-create-rdp-connection-to-computer?source=recommendations)

Describes an issue in which computer freezes when you create an RDP connection to Windows Server 2012 R2.
- [Poor performance or application problems during remote desktop connection - Windows Server](https://learn.microsoft.com/en-us/troubleshoot/windows-server/remote/poor-performance-application-problems-rdc?source=recommendations)

Troubleshoot poor performance or application problems during remote desktop connection.
- [Local computer behaves as if the Windows logo key is pressed after you switch from a Remote Desktop session - Windows Client](https://learn.microsoft.com/en-us/troubleshoot/windows-client/remote/local-computer-behaves-as-if-windows-logo-key-pressed?source=recommendations)

Fixes an issue in which the Windows logo key is displayed as pressed after you use an RDP session in Windows.
- [Applications crash if another user logs off - Windows Server](https://learn.microsoft.com/en-us/troubleshoot/windows-server/remote/applications-crash-if-another-user-logs-off-session?source=recommendations)

Discusses an issue in which applications crash or become unresponsive if another user logs off a Remote Desktop session in Windows Server 2012/R2 or Windows Server 2008/R2.
- [Client is disconnected during Group Policy update - Windows Server](https://learn.microsoft.com/en-us/troubleshoot/windows-server/remote/client-disconnected-group-policy-updates?source=recommendations)

Describes an issue in which clients are disconnected from Remote Desktop sessions.