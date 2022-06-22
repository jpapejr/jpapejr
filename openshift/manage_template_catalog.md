# Managing/Removing Templates from the OpenShift Catalog

Sometimes, cluser admins want to limit the types of resources that can be creatd in their clusters by developers. They can be accomplished with both broad and more-fine grained strokes of the pen, per se. 

## Broad stroke - remove the catalog completely

```
oc  edit config.samples.operator.openshift.io/cluster -n openshift
```

Edit the `spec.managementSpec` value from `Managed` to `Removed` and the catalog content will be removed. 

>Note: anything already created will still remain in the catalog based on my observations.

To return things back to normal, restore the `Managed` state back to the `spec.managementSpec` field.

## Finer-grained control

```
oc  edit config.samples.operator.openshift.io/cluster -n openshift
```

Add/Edit the `spec.skippedTemplates` value (as an array) to configure OpenShift to ignore creating/updating those Templates. Example:

```
  skippedTemplates:
    - dancer-mysql-example
    - dancer-mysql-persistent
```

A listing of the available Template objects available in the cluster can be found by running `oc get Templates -n openshift`.

After adding the desired Template resource names to the `skippedTemplates` field, the Templates can then be deleted, if desired. If the Template resource names are later removed from the `skippedTemplates` field, OpenShift should recreate them again. 

Reference: https://docs.openshift.com/container-platform/4.3/openshift_images/configuring-samples-operator.html