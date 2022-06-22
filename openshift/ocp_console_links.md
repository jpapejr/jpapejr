## ConsoleLinks

ConsoleLinks are the OpenShift custom resource that can be used to put custom links into
the menu items in the masthead of the OCP web console. You can put whatever links you want. 


``` yaml
apiVersion: console.openshift.io/v1
kind: ConsoleLink
metadata:
  name: jtp-test
spec:
  applicationMenu:
    imageURL: 'https://maxcdn.icons8.com/Share/icon/p1em/Logos/github1600.png'
    section: My Stuff
  href: 'https://jpapejr.github.io'
  location: ApplicationMenu
  text: John's Github Dump
```