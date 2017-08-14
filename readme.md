# Slack Tipbot

#### Reddcoin crypto currency tipbot for [Slack](https://slack.com)

## Setup

We're using [digitalocean.com](https://digitalocean.com) so these instructions will be specific to that plaform.

### Create and configure droplet

#### Create droplet 

* Go to digitalocean.com and create a new droplet
  * hostname: reddbot
  * Size
    * I usually go w/ 2GB/2CPUs $20 month
  * Region
    * San Francisco
  * Linux Distributions
    * Ubuntu 14.04 x64
  * Applications
    * Dokku
  * Add SSH keys

#### Configure hostname

* Copy/Paste IP address into URL bar
  * Put in `hostname`
    * `example.com`
  * Check `Use virtualhost naming for apps
    * `http://<app-name>.example.com`
  * Finish Setup

#### Add DNS

* You'll need a domain for this. For this documentation I'm using `example.com`
* Point your domain's nameservers to digitalocean
  * `ns1.digitalocean.com`
  * `ns2.digitalocean.com`
  * `ns3.digitalocean.com`
* In digitalocean's `DNS` section set an `A-Record` for your `hostname` from your previous step
  * Make the `hostname` be the name of your app
    * `reddbot`
  * Make the IP address be the one provided by digitalocean for your droplet.
* After the DNS propogates
  * In the `Zone file` of the DNS section of digital ocean you'll see:
    * `reddbot IN A	143.143.243.143`
  * `ping reddbot.example.com`
    * `PING reddbot.example.com (143.143.243.143): 56 data bytes`

#### SSH into your new virualized box

* `ssh root@ip.address.of.virutalized.box`
  * If you correctly added your SSH keys you'll get signed in
  * Remove root login w/ password
    * `sudo nano /etc/ssh/sshd_config`
      * `PermitRootLogin without-password`

#### Compile reddcoind

For this example I'm using reddcoin but the instructions should be similar for most other coins.

* Update and install dependencies
  * `apt-get update && apt-get upgrade`
  * `apt-get install ntp git build-essential libssl-dev libdb-dev libdb++-dev libboost-all-dev libqrencode-dev`
  * `wget http://miniupnp.free.fr/files/download.php?file=miniupnpc-1.8.tar.gz && tar -zxf download.php\?file\=miniupnpc-1.8.tar.gz && cd miniupnpc-1.8/`
  * `make && make install && cd .. && rm -rf miniupnpc-1.8 download.php\?file\=miniupnpc-1.8.tar.gz`
* Download the source code
  * `git clone https://github.com/reddcoin-project/reddcoin`
* Compile reddcoind
  * `cd reddcoin/src`
  * `make -f makefile.unix USE_UPNP=1 USE_QRCODE=1 USE_IPV6=1`
  * `strip reddcoind`
* Add a user and move reddcoind
  * `adduser reddcoin && usermod -g users reddcoin && delgroup reddcoin && chmod 0701 /home/reddcoin`
  * `mkdir /home/reddcoin/bin`
  * `cp ~/reddcoin/src/reddcoind /home/reddcoin/bin/reddcoin`
  * `chown -R reddcoin:users /home/reddcoin/bin`
  * `cd && rm -rf reddcoin`
* Run the daemon
  * `su reddcoin`
  * `cd && bin/reddcoin`    
  * On the first run, reddcoin will return an error and tell you to make a configuration file, named reddcoin.conf, in order to add a username and password to the file.
    * `nano ~/.reddcoin/reddcoin.conf && chmod 0600 ~/.reddcoin/reddcoin.conf`
    * Add the following to your config file, changing the username and password
    * to something secure. Make sure to take note of the `rpcuser` and * `rpcpassword` because you'll need them in a couple of steps
      * `daemon=1`
      * `rpcuser=reddrpc`
      * `rpcpassword=Z01BBDFKF`
      * `port=45443`
      * `rpcport=8332`
      * `rpcthreads=100`
      * `irc=0`
      * `dnsseed=1`
  * Run the daemon again
    * `cd && bin/reddcoind` 
  * To confirm that the daemon is running
    * `cd && bin/reddcoind getinfo`
  * Now wait for the blockchain to sync

#### Clone the Reddbot Bot git repo

* `git clone https://github.com/samgos/reddbot`
* Install bundler
  * `apt-get install bundler`
* Install Ruby 2.1.1 and rvm
  * `\curl -sSL https://get.rvm.io | bash -s stable --ruby`
  * To start using RVM you need to run `source /usr/local/rvm/scripts/rvm`
* Run `bundle`

#### Set up the Slack integration: as an "outgoing webhook" 

* https://yoursite.slack.com/services/new/outgoing-webhook
* Write down the api token they show you in this page
* Set the trigger word, use `reddbot`
* Set the Url to the server you'll be deploying on http://example.com:4567/tip


#### Launch the server!

* `RPC_USER=reddrpc RPC_PASSWORD=your_pass SLACK_API_TOKEN=your_api_key COIN=reddcoin bundle exec ruby tipper.rb -p 4567`
  

## Security

This runs an unencrypted hot wallet on your server. You should not store significant amounts of cryptocoins in this wallet. Withdraw your tips to an offline wallet often. 

## Credits

This project was originally forked from [dogetip-slack](https://github.com/tenforwardconsulting/dogetip-slack) by [tenforwardconsulting](https://github.com/tenforwardconsulting)

