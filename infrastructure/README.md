BZFlag Infrastructure
=====================

This uses Ansible to set up the web services for the BZFlag project.

Installing Ansible
------------------

This assumes we're using the latest version of Ansible and will be installing it using pipx.

```shell
pipx install --include-deps ansible
pipx inject --include-apps ansible jmespath
```

For developers working on the Ansible playbook, installing ansible-lint is also suggested.

```shell
pipx inject --include-apps ansible ansible-lint
```

Running the playbook
--------------------

Set up an inventory.ini file, replacing the IP address with the IP or hostname of the target server:
```ini
[mainserver]
192.0.2.42
```

Copy `settings.example.yml` to `settings.yml` and edit settings as desired. If you enable the
`forums.upload_local_archive` option, then download the matching phpBB .tar.bz2 archive from the phpBB download site.

Set up your environment so that it is possible for Ansible to SSH in to the target server. Then run the playbook:
```shell
ansible-playbook playbook.yml -i inventory.ini -u RemoteUserHere --ask-become-pass
```
