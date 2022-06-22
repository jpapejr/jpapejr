Have the problem were your VMWare VMs lose network connection to public network when you turn on Cisco AnyConnect on your Mac?

Add 

```
nat-anchor "com.apple.internet-sharing/*"
rdr-anchor "com.apple.internet-sharing/*"
```

to your `/etc/pf.conf` file and either reboot or do `sudo pfctl -d` followed by `sudo pfctl -e -f /etc/pf.conf`. 

Result should look like: 

```
#
# Default PF configuration file.
#
# This file contains the main ruleset, which gets automatically loaded
# at startup.  PF will not be automatically enabled, however.  Instead,
# each component which utilizes PF is responsible for enabling and disabling
# PF via -E and -X as documented in pfctl(8).  That will ensure that PF
# is disabled only when the last enable reference is released.
#
# Care must be taken to ensure that the main ruleset does not get flushed,
# as the nested anchors rely on the anchor point defined here. In addition,
# to the anchors loaded by this file, some system services would dynamically
# insert anchors into the main ruleset. These anchors will be added only when
# the system service is used and would removed on termination of the service.
#
# See pf.conf(5) for syntax.
#

#
# com.apple anchor point
#
set limit {tables 10000, table-entries 400000}
scrub-anchor "cisco.anyconnect.vpn"
scrub-anchor "com.apple/*"
nat-anchor "com.apple/*"
rdr-anchor "com.apple/*"
nat-anchor "com.apple.internet-sharing/*"
rdr-anchor "com.apple.internet-sharing/*"
dummynet-anchor "com.apple/*"
anchor "cisco.anyconnect.vpn"
load anchor "cisco.anyconnect.vpn" from "/opt/cisco/anyconnect/ac_pf.conf"
anchor "com.apple/*"
load anchor "com.apple" from "/etc/pf.anchors/com.apple"
# com.crowdstrike anchor point
anchor "com.crowdstrike"
load anchor "com.crowdstrike" from "/etc/pf.anchors/com.crowdstrike"
```

### Note the placement of the new lines just after the 

```
nat-anchor "com.apple/*"
rdr-anchor "com.apple/*"
```

> Thread reference https://communities.vmware.com/t5/VMware-Fusion-Discussions/macOS-Big-Sur-Fusion-12-NAT-no-internet-connection/td-p/2809034/page/6
