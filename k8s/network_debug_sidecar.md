## Network debug sidecar (courtesy of @nfritze (https://github.com/nfritze) )

```
- name: debug-sidecar
        image: alpine/k8s:1.28.3
        securityContext:
          privileged: true
        command: 
        - bash
        - "-c"
        - |
          /bin/bash <<'EOF'
          apk add --no-cache curl bc tcpdump
          export SLOW_RESPONSE_TIME="5.0"
          export CURL_TIMEOUT=15
          export TEST_URL="https://s3.direct.jp-tok.cloud-object-storage.appdomain.cloud"
          while true; do
            export SSLKEYLOGFILE=""
            export CURL_RESPONSE_TIME=`curl -w "%{time_total}" -m $CURL_TIMEOUT -o /dev/null -s $TEST_URL`
            if (( $(echo "$CURL_RESPONSE_TIME > $SLOW_RESPONSE_TIME" |bc -l) )); then
              export capfile="/apps/`date '+%Y%m%d%H%M%S'`-slow"
              echo "`date` curl slow response $CURL_RESPONSE_TIME seconds to url $TEST_URL"
              echo "  collecting data"
              tcpdump -i eth0 -n -s 0 -C 50 -W 3 -w $capfile.pcap & 
              pid=$(ps -e | pgrep tcpdump)
              export SSLKEYLOGFILE=$capfile.tlskeys
              curl -vvv $TEST_URL -s >$capfile.out 2>&1
              sleep 60
              kill -2 $pid
              echo "  curl out written to $capfile.out"
              echo "  pcap written to $capfile.pcap*"
              echo "  tlskeys in $SSLKEYLOGFILE"
              sleep 600
            else
              echo "`date` curl normal response $CURL_RESPONSE_TIME seconds to url $TEST_URL"
            fi
            sleep 15
          done
```

Example output 

```
Wed Jun  5 15:23:28 UTC 2024 curl slow response 0.035331 seconds to url https://s3.direct.jp-tok.cloud-object-storage.appdomain.cloud
  collecting data
tcpdump: listening on eth0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
  curl out written to /apps/20240605152328-slow.out
  pcap written to /apps/20240605152328-slow.pcap*
  tlskeys in /apps/20240605152328-slow.tlskeys
130 packets captured
130 packets received by filter
0 packets dropped by kernel
```

Useful to copy the files back to a local subdir (say `./out`) using `oc cp -c debug-sidecar $PODID:/apps/ ./out/`

