## sshuttle - a poor engineer's vpn


Reference link - https://sshuttle.readthedocs.io/en/stable/

### Step 1
`brew install sshuttle`

### Step 2
` sshuttle -NHr root@150.239.82.74 10.0.0.0/8 161.26.0.0/16 166.8.0.0/14 --ssh-cmd 'ssh -i ~/Downloads/qualtrics-pci.prv' -v`

>The command above will set up a transparent proxy on the the local Mac machine that will push traffic destined for the CIDRs of `10.0.0.0/8`, `161.26.0.0/16`, and `166.8.0.0/14` over the SSH tunnel using the identity file located at `~/Downloads/qualtrics-pci.prv' with verbose output. 
