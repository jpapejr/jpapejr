Get OpenShift CLI

`curl -sLO https://mirror.openshift.com/pub/openshift-v4/clients/oc/latest/linux/oc.tar.gz && tar xvfz ./oc.tar.gz && mv oc /usr/local/bin/oc && chmod ugo+x /usr/local/bin/oc`

then

`alias oc='/lib/ld-musl-x86_64.so.1 --library-path /lib /usr/local/bin/oc'`


This is all needed because Red Hat isn't building static binaries for the CLI. 