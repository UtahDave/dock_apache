apache-image:
   docker.pulled:
     - name: utahdave/saltdemo
     - require_in: apache-container

apache-container:
   docker.installed:
     - name: apache
     - hostname: apache
     - image: utahdave/saltdemo
     - require_in: apache

apache:
   docker.running:
     - container: apache
     - port_bindings:
            "80/tcp":
                HostIp: ""
                HostPort: "8000"

apache-container2:
   docker.installed:
     - name: apache2
     - hostname: apache2
     - image: utahdave/saltdemo
     - require_in: apache2

apache2:
   docker.running:
     - container: apache2
     - port_bindings:
            "80/tcp":
                HostIp: ""
                HostPort: "8080"
