# Inception

## Project Description

## Requirements

1. The whole project has to be done in a virtual machine.
2. You have to use `docker compose`.
3. Each Docker image must have the same name as its corresponding service.
4. Each service has to run in a dedicated container.
5. The containers must be built ~~either~~ from ~~the penultimate stable version of Alpine or~~ `Debian`.
6. You have to write your own `Dockerfiles`, one per service. I.e. you have to build yourself the Docker images of your project.
7. The `Dockerfiles` must be called in your `docker-compose.yml` by your `Makefile`.
8. It is **forbidden** to pull *ready-made Docker images*, as well as using services such as `DockerHub` *(Alpine/Debian being excluded from this rule)*

## Tasks _(to do)_

### Mandatory Part

1. A *Docker container* that contains **NGINX** with *TLSv1.2* or *TLSv1.3* only.
2. A *Docker container* that contains **WordPress** + **php-fpm** *(it must be installed and configured)* only *without nginx*.
3. A *Docker container* that contains **MariaDB** only *without nginx*.
4. A *volume* that contains your **WordPress database**.
5. A *second volume* that contains your **WordPress website files**.
6. A `docker-network` that establishes the connection between your containers.
7. a. In your WordPress database, there must be two users, one of them being the administrator.
  b. The administrator’s username can’t contain admin/Admin or administrator/Administrator (e.g., admin, administrator, Administrator, admin-123, and so forth).
8. Your volumes will be available in the `/home/login/data` folder of the host machine using Docker. Of course, you have to replace the login with yours.
9. You have to configure your domain name so it points to your local IP address. This domain name must be `login.42.fr`. I.e. you have to use your own login. E.g. if your login is `wil`, `wil.42.fr` will redirect to the IP address pointing to `wil`’s website.

- **Notes**
  - Your containers have to restart in case of a crash.
  - It is not recommended to use any hacky patch based on `tail -f` and so forth when trying to run a Docker Container.
  - Read about how daemons work and whether it’s a good idea to use them or not.
  - Using `network: host` or `--link` or `links:` is forbidden.
  - The network line must be present in your `docker-compose.yml` file.
  - Your containers musn’t be started with a command running an infinite loop. Thus, this also applies to any command used as entrypoint, or used in entrypoint scripts.
  - The following are a few prohibited hacky patches: `tail -f`, `bash`, `sleep infinity`, `while true`.
  - Read about **PID 1** and the best practices for writing *Dockerfiles*.
  - The `latest` tag is prohibited.
  - No password must be present in your *Dockerfiles*.
  - It is mandatory to use environment variables.
  - Also, it is strongly recommended to use a `.env` file to store environment variables.
  - The `.env` file should be located at the root of the `srcs` directory.
  - Your **NGINX** container must be the only entrypoint into your infrastructure via the port `443` only, using the *TLSv1.2* or *TLSv1.3* protocol.

### Bonus Part

1. A *Dockerfile* must be written for each extra service. Thus, each one of them will run inside its own container and will have—if necessary—its dedicated volume.
2. Set up `redis cache` for your WordPress website in order to properly *manage the cache*.
3. Set up a **FTP server** container *pointing to the volume* of your WordPress website.
4. Create a **simple static website** in the language of your choice *except PHP* *(Yes, PHP is excluded!)*. For example, a showcase site or a site for presenting your resume.
5. Set up **Adminer**
6. Set up a service of your choice that you think is useful. During the defense, you will have to justify your choice.

- **Notes**
  - To complete the bonus part, you have the possibility to set up extra services. In this case, you may open more ports to suit your needs.

## Services

### Wordpress

### MariaDB

### Nginx

### FTP

```conf
local_enable=YES                                    # When set to YES, allows local users to log in to the FTP server.
xferlog_enable=YES                                  # When set to YES, enables logging of file transfer activities on the FTP server.
xferlog_file=/dev/stdout                            # Specifies the file where the file transfer logs will be written. In this case, it is set to /dev/stdout.

connect_from_port_20=YES                            # When set to YES, the FTP server will require incoming data connections to originate from port 20.
seccomp_sandbox=NO                                  # If set to YES, vsftpd will use seccomp to sandbox the FTP server, which is a security feature. However, in this case, it is set to NO.
write_enable=YES                                    # Allows write access to the FTP server for authenticated users.
anonymous_enable=NO                                 # When set to NO, anonymous access to the FTP server is disabled.
dirmessage_enable=YES                               # When set to YES, allows messages to be displayed when a user changes directories on the FTP server.

chroot_local_user=YES                               # When set to YES, users will be jailed into their home directories upon login.
allow_writeable_chroot=YES                          # When set to YES, authenticated users will be allowed to upload files even when chrooted into their home directory.
user_sub_token=$USER                                # Allows the use of the $USER variable to substitute the authenticated username in the local_root option.
local_root=/var/www/wordpress                       # Specifies the directory that will be used as the root directory for the FTP server. In this case, it is set to /var/www/wordpress.

listen=YES                                          # When set to YES, the FTP server will listen for incoming connections.
listen_port=21                                      # Specifies the port number that the FTP server will listen on. In this case, it is set to 21.
listen_address=0.0.0.0                              # Specifies the IP address that the FTP server will listen on.

pasv_address=0.0.0.0                                # Specifies the IP address that will be used for passive mode connections.
pasv_addr_resolve=NO                                # When set to NO, the FTP server will not try to resolve the IP address of the client for passive mode connections.
pasv_enable=YES                                     # Enables passive mode connections to the FTP server.
pasv_min_port=10000                                 # Specifies the minimum port number to be used for passive mode connections.
pasv_max_port=10100                                 # Specifies the maximum port number to be used for passive mode connections.
port_enable=YES                                     # Enables active mode connections to the FTP server.

userlist_enable=YES                                 # Enables the use of a user list file, which is specified in the userlist_file option.
userlist_file=/etc/vsftpd.userlist                  # Specifies the file containing a list of users who are allowed to connect to the FTP server.
userlist_deny=NO                                    # When set to NO, allows users on the userlist_file to connect to the FTP server. If set to YES, denies access to users on the userlist_file.

secure_chroot_dir=/var/www                          # Specifies the directory where the chroot jail for users will be created. In this case, it is set to /var/www.

# ssl_enable=YES                                      # Enables SSL/TLS encryption for the FTP server.
# rsa_cert_file=/etc/ssl/private/vsftpd.crt           # Specifies the location of the SSL/TLS certificate file.
# rsa_private_key_file=/etc/ssl/private/vsftpd.key    # Specifies the location of the SSL/TLS private key file.
# ssl_tlsv1=YES                                       # Enables TLS v1.0 encryption for the FTP server.
# ssl_sslv2=NO                                        # Disables SSL v2 encryption for the FTP server.
# ssl_sslv3=NO                                        # Disables SSL v3 encryption for the FTP server.
# ssl_ciphers=HIGH                                    # Specifies the SSL/TLS ciphers that will be used for encryption. In this case, it is set to HIGH.
# require_ssl_reuse=NO                                # If set to YES, requires that SSL/TLS session reuse be used for data transfers.
# force_local_data_ssl=YES                            # When set to YES, forces SSL/TLS encryption for data transfers.
# force_local_logins_ssl=YES                          # When set to YES, forces SSL/TLS encryption for user logins.
# allow_anon_ssl=NO                                   # When set to NO, anonymous users are not allowed to use SSL/TLS encryption for data transfers.

# local_umask=022                                     # Specifies the default umask for file permissions on the FTP server.

# use_localtime=YES                                   # When set to YES, the FTP server will use the local system time instead of UTC time for file timestamps.
# pam_service_name=vsftpd                             # Specifies the name of the PAM service that will be used for authentication.
# isolate_network=NO                                  # When set to YES, the FTP server will try to isolate network sessions for each user.
```


```conf
local_enable=YES
xferlog_enable=YES
xferlog_file=/dev/stdout
connect_from_port_20=YES
seccomp_sandbox=NO
write_enable=YES
anonymous_enable=NO
dirmessage_enable=YES
chroot_local_user=YES
allow_writeable_chroot=YES
user_sub_token=$USER
local_root=/var/www/wordpress
listen=YES
listen_port=21
listen_address=0.0.0.0
pasv_address=0.0.0.0
# pasv_addr_resolve=NO
pasv_addr_resolve=YES
pasv_enable=YES
pasv_min_port=10000
pasv_max_port=10100
port_enable=YES
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
secure_chroot_dir=/var/www
ssl_enable=YES
rsa_cert_file=/etc/ssl/private/vsftpd.crt
rsa_private_key_file=/etc/ssl/private/vsftpd.key
# blablabla=BLABLA
allow_anon_ssl=NO
force_local_data_ssl=YES
force_local_logins_ssl=YES
ssl_tlsv1=YES
ssl_sslv2=NO
ssl_sslv3=NO
require_ssl_reuse=NO
ssl_ciphers=HIGH
isolate_network=NO

```

### cAdvisor

### Adminer

### Redis

### Static-Website

