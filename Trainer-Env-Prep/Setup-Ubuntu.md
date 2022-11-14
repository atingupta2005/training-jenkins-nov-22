# Trainer Tasks

```
sudo apt -y update
```

```
sudo apt -y install openssl tree
```

## Setup multiple users in Ubuntu
- For each participant, we need to setup login accounts
sudo groupadd docker
```
sudo groupadd docker
for ((i=1;i<=20;i++)); do
	export username="u$i"
	sudo useradd -m -p "p2" $username;sudo usermod -aG sudo $username;sudo usermod -aG docker $username;echo $username:p | sudo /usr/sbin/chpasswd;sudo chown -R  $username:root /home/$username
done
```

-  Clone Git Repo
```
cd
git clone
cd
```

- Customize linux prompt
```
cat ~/.bashrc
echo 'export PS1="\e[0;31m\e[50m\u@\h\n\w \e[m\n$ "'   >> ~/.bashrc
cat ~/.bashrc
exit
```

- Setup R Studio
```
sudo apt -y update
sudo apt-get -y install r-base
sudo apt-get  -y install gdebi-core
wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2021.09.0-351-amd64.deb
sudo gdebi rstudio-server-2021.09.0-351-amd64.deb
free -h
curl http://localhost:8787
```

- Enable Swap Space
```
sudo nano /etc/waagent.conf
sudo systemctl restart walinuxagent
sudo reboot
```
