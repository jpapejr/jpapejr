# Manually triggering a CronJob on-demand

`oc create job --from=cronjob/my-cronjob my-adhoc-job -n <namespace>`