**Step 1** 

```
subscription-manager repos --enable rhel-7-server-extras-rpms
```

**Step 2** 

```
yum install -y cockpit cockpit-networkmanager cockpit-packagekit cockpit-storaged
```

**Step 3**

```
systemctl enable --now cockpit.socket
```

[Optional if `firewalld` is up]

**Step 4**

```
firewall-cmd --add-service=cockpit --permanent
```

**Step 5**

```
firewall-cmd --reload
```


Host should be accessible at https://<host ip>:9090