### Manual
```
ssh -f -N -L 9443:localhost:9999 root@108.168.187.171
```

### More automated
```
autossh -f -M 20000 -N -n -T -i /path/to/secure.key -R 9443:localhost:9999 root@108.168.187.171
```