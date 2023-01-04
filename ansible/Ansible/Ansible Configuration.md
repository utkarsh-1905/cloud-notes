Ansible uses configuration files for its operation.
By default, it uses the default config file  `ansible.cfg` stored in the `/etc/ansible` root directory. This configuration file has the least priority, i.e any cfg file provided to it will be used rather than using the default one. 
Priorities for the config file to be used by Ansible : (test - create these files and run `ansible --version` and notice the config file section)
4) cfg file in root directory
3) `~/.ansible.cfg` present in the users home directory
2) `./ansible.cfg` in the current directory
1) `ANSIBLE_CONFIG` environment variable, which may contain a file path