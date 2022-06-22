```
sudo iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to 10.97.69.229:80
```