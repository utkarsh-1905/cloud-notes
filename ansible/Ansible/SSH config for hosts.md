We need to configure ssh access to all the machines in our host to which ansible will try to access.

We also need to configure out host in the target machine as `known_hosts` so that ansible can ssh into them without password.

We can initially ssh into a target machine via `ssh hostname/ip addr` which promts to confirm fingerprint then type in the password and then stores the machine fingerprint into `/home/user/.ssh/know_hosts` file.

## Steps to configure SSH without password

- Create a pub/private key pair using `ssh-keygen` command. It will create a key pair in the root .ssh directory.
- We can manually copy the public key and add it to known hosts of all target machines but that will by cumbersome so we use a tool which comes by default in unix, i.e. `ssh-copy-id`. It ssh into the machine and securely copies this pub key to that machine.
- Example - `ssh-copy-id centos1` will ask the root password of that machine and copy the file so that next time we do not need to enter password to ssh into this machine.
- But using this command to copy the key to every machine is still tedios, so we use a tool called `sshpass`
- To use this, first `sudo apt update` and then `sudo apt install sshpass`.
- Then create a bash script in the terminal to target all users, os ans hosts to copy this file
- We need to copy this key to two users namely `root` and `ansible` on two os `centos` and `ubuntu` and there are 3 instances of both the os.
- Create a password.txt file containing password of the target. Since we have same password as password for all machines, we use `echo password > password.txt`.

```bash
for user in root ansible 
do
	for os in centos ubuntu 
	do
		for instance in 1 2 3
		do
			sshpass -f password.txt ssh-copy-id -o StrictHostKeyChecking=no ${user}@${os}${instance}
		done
	done
done
```
