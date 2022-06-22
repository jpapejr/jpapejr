https://github.com/kvaps/kubectl-build is great.. But how do I tell it to build an image and then push it 
to an insecure registry like the run I'd run alongside my KinD cluster?

Answer: just add `--output=type=image,push=true,registry.insecure=true` to the end of the command.. 

e.g. `kubectl build -t 192.168.72.28:5000/got-kbuilder:latest --output=type=image,push=true,registry.insecure=true .`

Done. 