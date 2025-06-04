---
title: "OpenShift Console on MicroShift"
source: "https://gist.github.com/adelton/d3d1312ebc16578b63517ffe601cc69b"
author:
  - "[[Gist]]"
published:
created: 2025-03-05
description: "OpenShift Console on MicroShift. GitHub Gist: instantly share code, notes, and snippets."
tags:
  - "clippings"
---
On MicroShift 4.13 installed on RHEL 9.2 using [Installing and configuring MicroShift clusters product documentation](https://access.redhat.com/documentation/en-us/red_hat_build_of_microshift/4.13/html-single/installing/index), OpenShift Console can be enabled on port :9000 by fetching the files from this gist and then running

```
# oc create serviceaccount -n kube-system openshift-console
# bash openshift-console.eval | oc create -f -
```

If you don't like the idea of running bash on a random script downloaded from the web, run

```
# oc create token -n kube-system openshift-console
# hostname -f
```

and edit the openshift-console.yaml file and replace `$( hostname -f )` and `$( oc create token -n kube-system openshift-console )` with the outputs of commands above. Then run

```
# oc create -f openshift-console.yaml
```

You can also use `--duration=...` to specify longer than standard duration of the token created. If the token expires and the console URL stops serving the OpenShift console content, you can refresh the token with

```
oc set env -n kube-system deployment/openshift-console-deployment BRIDGE_K8S_AUTH_BEARER_TOKEN=$( oc create token -n kube-system openshift-console )
```

Beware: there is no authentication, so only use for test purposes on well-controlled network.