## My containers stop when I log out of my FCOS host

As the admin user run: `loginctl enable-linger` to resolve. 

To check if `linger` is set for a user: `loginctl show-user <username>`

Example output for `core` user with `linger` **enabled**:

``` shell
UID=1000
GID=1000
Name=core
Timestamp=Fri 2024-09-27 15:41:01 UTC
TimestampMonotonic=5325767655
RuntimePath=/run/user/1000
Service=user@1000.service
Slice=user-1000.slice
Display=6
State=active
Sessions=6
IdleHint=no
IdleSinceHint=1727451904000000
IdleSinceHintMonotonic=5567926046
Linger=yes
```