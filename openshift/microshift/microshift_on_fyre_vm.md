Provisioned a RHEL9 VM in Fyre. 

`systemctl enable --now cockpit.socket` *exposed on :9090*

Re-registered with RHSM using default settings (`baseurl = subscription.rhsm.redhat.com`) and my `jtpape_nfr` activation key for org `15478606`. Find in [console.redhat.com](https://console.redhat.com)


Enable `rhocp-4.18-for-rhel-9-x86_64-rpms` and `fast-datapath-for-rhel-9-x86_64-rpms` and `dnf repolist` to confirm


Deploy according to [[Red Hat build of MicroShift  Red Hat Product Documentation]]

`dnf install microshift-olm`

`export KUBECONFIG=/var/lib/microshift/resources/kubeadmin/kubeconfig`