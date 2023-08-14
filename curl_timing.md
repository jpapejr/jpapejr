### How to gather basic response time metrics using cURL

Set up a template file that defines the structure and the metrics to record called `curl-format.txt`: 

```
time_namelookup:  %{time_namelookup}s\n
        time_connect:  %{time_connect}s\n
     time_appconnect:  %{time_appconnect}s\n
    time_pretransfer:  %{time_pretransfer}s\n
       time_redirect:  %{time_redirect}s\n
  time_starttransfer:  %{time_starttransfer}s\n
                     ----------\n
          time_total:  %{time_total}s\n

```

Use the following script to drive the test: 

``` shell
#!/bin/bash

while (true); do
  printf "\n\n--`date`--\n"
  curl -w "@curl-format.txt" -o /dev/null -s "$1"
  sleep $2
done
```
