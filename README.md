# sandboxes

#### Required Software
- [Git Large File Storage](https://git-lfs.github.com/)
- [VMware Fusion Pro](http://store.vmware.com/store?SiteID=vmware&Action=DisplayProductDetailsPage&productID=5124967100)
- [Packer](https://www.packer.io/downloads.html)
- [Vagrant](https://www.vagrantup.com/downloads.html)
- [Vagrant VMware Provider Plugin](https://www.vagrantup.com/docs/vmware/installation.html)
- [Vagrant Hostmanager Plugin](https://github.com/devopsgroup-io/vagrant-hostmanager)

#### Add the personal private key and Vagrant's private key to OS X Keychain

  1. Download Vagrant's [public SSH key](https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub) and [private SSH key](https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant).

  2. Put the SSH keys under `$HOME/.ssh` and set the appropriate permissions on Vagrant's private key.

  ```
  macOS$ chmod 400 $HOME/.ssh/vagrant
  ```

  3. Starting with OS X Leopard, ssh-agent is more tightly integrated with Keychain.  Securely storing the passphrases tied to all of a user's SSH keys in Keychain is now possible.  Once added, `ssh-agent` will automatically load them on boot.

  ```
  macOS$ ssh-add -K $HOME/.ssh/<your_private_key>
  macOS$ ssh-add -K $HOME/.ssh/vagrant
  ```

- [How to use Mac OS X Keychain with SSH keys?](http://superuser.com/questions/88470/how-to-use-mac-os-x-keychain-with-ssh-keys)

#### Create the `devops` Vagrant Machine

  1. Clone the `sandboxes` repo.

  ```
  macOS$ git clone git@github.com:yhuang/sandboxes.git
  macOS$ cd sandboxes
  ```

  2. Download `CentOS-7-x86_64-DVD-1611.iso` from a trusted source.  Create the `iso` directory under the `sandboxes` top-level directory, and put the ISO file under the `iso` directory.

  3. Build the `devops` Vagrant box.

  ```
  macOS$ packer build packer-templates/devops.json
  ```

  4. Add the `devops` Vagrant box.

  ```
  macOS$ vagrant box add builds/devops.vmware.box --name devops
  ```

  5. Launch the `devops` Vagrant box.

  ```
  macOS$ cd vagrantfiles/devops; vagrant up; cd ../..
  ```

#### Log onto the `devops` Vagrant Machine
Once up, the `devops` Vagrant machine may be accessed via either `vagrant ssh`
```
macOS$ cd vagrantfiles/devops; vagrant ssh
```

#### Set up the `devops` Vagrant Machine
These steps assume the following about the host Mac OS X machine:

  1. The ssh keys to remote machines are stored under `$HOME/.pem/` on Mac OS X;

  ```
  vagrant@devops% ln -s /host-data/.pem/ $HOME/.pem
  ```

  2. The public ssh key and private ssh key for the user on Mac OS X are `$HOME/.ssh/id_rsa.pub` and `$HOME/.ssh/id_rsa` respectively;

  ```
  vagrant@devops% ln -s /host-data/.ssh/id_rsa.pub $HOME/.ssh/id_rsa.pub
  vagrant@devops% ln -s /host-data/.ssh/id_rsa $HOME/.ssh/id_rsa
  vagrant@devops% chmod 644 $HOME/.ssh/id_rsa.pub
  vagrant@devops% chmod 600 $HOME/.ssh/id_rsa
  ```

  3. The service account tokens are exported as environmental variables in `$HOME/.credentials`; and

  ```
  vagrant@devops% ln -s /host-data/.credentials .credentials
  vagrant@devops% source $HOME/.bash_profile
  ```

  4. The project directories are under `$HOME/workspace/`.

  ```
  vagrant@devops% ln -s /host-data/workspace/ $HOME/workspace
  ```
