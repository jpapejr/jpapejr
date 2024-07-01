# KeyCloak user federation via LDAP

You can use [this example setup](https://www.forumsys.com/2022/05/10/online-ldap-test-server/) to configure a KeyCloak instance to use LDAP as the identity provier for authentication requests for a given realm. 


### High-level flow

1. Install RH KeyCloak operator
2. Create KeyCloak CR (need ingress hostname and secret for TLS)
3. Create realm
4. Complete User Federation by adding LDAP provider.

> Turn off user import if you just want to use KeyCloak for lookups and not store user data in local DB.