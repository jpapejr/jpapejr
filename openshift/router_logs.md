# Getting OpenShift router access logs

Open the IngressController resource for the router instances you want to gather debug for and add the following yaml snippet under the `spec` field: 

``` yaml
  logging:
    access:
      destination:
        type: Container
      # % formats see here: http://cbonte.github.io/haproxy-dconv/2.0/configuration.html#8.2.3
      httpLogFormat: log_source="haproxy-default" log_type="http" c_ip="%ci" c_port="%cp"
        req_date="%tr" fe_name_transport="%ft" be_name="%b" server_name="%s" res_time="%TR"
        tot_wait_q="%Tw" Tc="%Tc" Tr="%Tr" Ta="%Ta" status_code="%ST" bytes_read="%B"
        bytes_uploaded="%U" captrd_req_cookie="%CC" captrd_res_cookie="%CS" term_state="%tsc"
        actconn="%ac" feconn="%fc" beconn="%bc" srv_conn="%sc" retries="%rc" srv_queue="%sq"
        backend_queue="%bq" captrd_req_headers="%hr" captrd_res_headers="%hs" http_request="%r"
```

> **FYI**: Do not leave this on in production without gauging the performance impact!!!

Reference https://stackoverflow.com/questions/48519103/how-to-get-access-logs-from-openshift-router-haproxy