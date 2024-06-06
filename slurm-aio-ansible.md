## This short playbook can be used to deploy a single-node Slurm cluster. 

``` yaml
---
- name: Slurm all in One
  hosts: localhost
  vars:
    slurm_roles: ['controller', 'exec', 'dbd']
    slurm_config:
      AccountingStorageType: "accounting_storage/slurmdbd"
    slurmdbd_config:
      StorageType: accounting_storage/mysql
      StorageHost: localhost
      StoragePass: new_password
      StorageLoc: slurm_acct_db
      StorageUser: root
  roles:
    - role: galaxyproject.slurm
      become: True
```
