===================
dock-apache formula
===================

A saltstack formula to set up a demo with docker containers serving up an http
response with the requester's IP address.

.. note::

    This demo depends on the haproxy-docker formula which can be found here:
    <https://github.com/UtahDave/haproxy-docker>`_.

To run this demo, your Salt Master and Salt Minions must be running the latest
development version of Salt, or "Helium". This demo has been run and tested on
Ubuntu 12.04 Precise and Ubuntu 14.04 Trusty. You should be able to run this
demo on other OS's with some slight modifications.

Please be sure to change the username and password if you modify this demo to
work in production.

First, copy the dock_apache and docker directories to `/srv/salt/` on your Salt
Master. Clone the haproxy-docker repo mentioned above and copy the haproxy
directory to `/srv/salt/` as well.

I'm assuming your haproxy vm is named "haproxy01" and your docker vms are named
"docker01, docker02, docker03, etc".

Run the following commmands to prepare your docker hosts:

1. sudo salt 'docker*' state.sls docker
2. sudo salt 'docker*' service.restart salt-minion
3. sudo salt 'docker*' state.sls dock_apache.pull
4. sudo salt 'docker*' state.sls dock_apache

You should now have 2 containers running on each docker minion serving up an
http response on ports 8080 and 8000 of each of your docker hosts.

Now, to set up your haproxy server run the following commands:

1. sudo salt 'haproxy*' state.sls haproxy
2. sudo salt 'haproxy*' state.sls haproxy.config

Determine your haproxy server's ip address:

  sudo salt 'haproxy*' network.ip_addrs

If you browse to that IP address you'll see the output of your docker
containers which has been proxied by haproxy.

You can view the haproxy stats at

http://<haproxy ip>/haproxy?stats

username: saltstack

password: saltstack
