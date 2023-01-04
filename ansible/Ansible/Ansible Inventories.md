These are basically a collection of all hosts to which ansible can ssh and make changes.
To get the hosts ansible uses the configuration file, that is, `ansible.cfg` acc to the hierarchy previosly stated.
```ini
[defaults]
inventory = hosts
host_key_checking = False
```

The hosts is a file present in the same directory as the configuration file. These files use the `ini` syntax.
Default method of adding hosts
```ini
[all]
centos1
```

This can be verified using the ping module in the ansible command line tool
```bash
ansible all -m ping
```
all is the group name in hosts file or all the hosts in the file. -m states the module to be used on the hosts, in this case the ping module.

Different host groups
```ini
[centos]
centos1
centos2
centos3

[ubuntu]
ubuntu1
ubuntu2
ubuntu3
```

```bash
ansible all -m ping # for all hosts in the file
ansible centos -m ping # for hosts under the centos group
ansible ubuntu -m ping # for all hosts under the ubuntu group
ansible all -m ping -o # the -o gives single line output
ansible centos --list-hosts # will list all the host in the group
ansible all --list-hosts # will list all the hosts in the file
# we can also use regex to match hosts
ansible ~.*3 -m ping # ~ marks the beginning of the regex
# . any character; * any number of previos; 3 - ending with 3
# it will output all hosts ending in 3 i.e centos3 and ubuntu3
```

### Specifying host variables
```ini
[centos]
centos1 ansible_user=root
centos2 ansible_user=root
centos3 ansible_user=root

[ubuntu]
ubuntu1
ubuntu2
ubuntu3
```
It specifies the user in centos.
To check we are ssh-ing using the root user, we run the `id` command with the command module of ansible. The command module is the default module and can be used without -m.
```bash
ansible centos -m command -a 'id' -o # will return the id data of the hosts
ansible centos 'id' -o # it is the same as above as command module is default
```

It is generally the best practice to first ssh and then get the root user or super user previleges rather ssh-ing as a root user. To facilitate this we pass some host variables as follows:

```ini
[centos]
centos1 ansible_user=root
centos2 ansible_user=root
centos3 ansible_user=root

[ubuntu]
ubuntu1 ansible_become=true ansible_become_pass=password
ubuntu2 ansible_become=true ansible_become_pass=password
ubuntu3 ansible_become=true ansible_become_pass=password
```

We can also the ranges in `.ini` hosts file to specifiy comman behavior. For eg:
```ini
[control]
ubuntu-c ansible_connection=local

[centos]
centos[1:3] ansible_user=root

[ubuntu]
ubuntu[1:3] ansible_become=true ansible_become_pass=password
```

We can use group var blocks to simplify this hosts file.

```ini
[control]
ubuntu-c ansible_connection=local

[centos]
centos[1:3]

[ubuntu]
ubuntu[1:3]

[centos:vars]
ansible_user=root

[ubuntu:vars]
ansible_become=true
ansible_become_pass=password
```

We can also specify groups with children to inherit properties like
```ini
[linux:children]
centos
ubuntu
```
When we ping the linux group, it automatically calls its children.

We can also write the hosts file in yaml format as:

```yaml
control:
	hosts:
		ubuntu-c:
			ansible_connection: local
centos:
	hosts:
		centos1:
		centos2:
		centos3:
		vars:
			ansible_user: root
ubuntu:
	hosts:
		ubuntu1:
		ubuntu2:
		ubuntu3:
		vars:
			ansible_become: true
			ansible_become_password: password
linux:
	children:
		ubuntu:
		centos:
```

