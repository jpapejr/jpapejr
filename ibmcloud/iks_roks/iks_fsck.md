When you see errors like 

`MountDevice operation has failed &errors.errorString{s:"'fsck' found errors on device /dev/dm-1 but could not correct them.... UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.\n\t(i.e., without -a or -p options)\n."}`


Try this: 

```
1. kubectl edit pv pvc-7c334421-11bd-11ea-8e6d-fa3086e7d91d
2. Add "ibm.io/autofix-fsckErr: true" under the annotation section
3. save PV
4. kubernetes will retry mount operation in few minutes and the block driver will try to autofix based upon this flag.
5. We suggest to remove this Annotation "ibm.io/autofix-fsckErr: true" from the PV after your error gets resolved and POD comes to running state
$ kubectl edit pv pvc-7c334421-11bd-11ea-8e6d-fa3086e7d91d
Remove "ibm.io/autofix-fsckErr: true" under the annotation section and Save
```

If that fails, ssh into worker and do 

```
Manual way to fix is to do a ssh login to Node and and run the "fsck DEVICEPATH", which prompts few Yes/No options from user and fix the disk.
```