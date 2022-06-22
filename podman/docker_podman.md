Reference this > https://y0n1.medium.com/using-podman-with-the-docker-extension-for-visual-studio-code-a828be26d285

**tl;dr**

As root:

`systemctl --user enable --now podman.socket unix:///run/user/0/podman/podman.sock`

Now setting your docker host to `unix:///run/user/0/podman/podman.sock` will allow any docker tooling to "just work".
