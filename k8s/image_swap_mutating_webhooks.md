## Swapping the image spec defined in a pod with another value

OpenShift provides some tooling around image mirroring from one registry to another. The typical use
case is the mirroring of images from a public registry to an internal registry where pulls can be done
over the private network and better image providence can be established. There are a couple of options
in the wild for vanilla k8s users: 

[pod-image-swap-webhook](https://pkg.go.dev/github.com/Bonial-International-GmbH/pod-image-swap-webhook#section-readme)

[phenixblue/imageswap-webhook](https://github.com/phenixblue/imageswap-webhook)

Both of these projects utilize a MutatingWebhook that looks at the image specified for Deployments, Daemonsets, 
etc and uses various complexities of logic to replace/restructure the image defined.. For example, you might set
a pattern to replace and image coming from `docker.io/ubuntu` to be replaced with `ghcr.io/bob/ubuntu`

 
