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

| Package name | Description |
| --- | --- |
| `php7.3` | This package installs PHP version 7.3, which is a popular server-side scripting language used for web development. |
| `php7.3-cgi` | This package provides the Common Gateway Interface (CGI) binary for PHP version 7.3, which allows PHP scripts to be executed by a web server. |
| `php7.3-fpm` | This package provides the FastCGI Process Manager (FPM) for PHP version 7.3, which is a high-performance alternative to the traditional CGI binary. FPM provides better performance and scalability by allowing PHP processes to be managed separately from the web server. |
| `php7.3-mysql` | This package provides support for MySQL in PHP version 7.3, allowing PHP scripts to interact with MySQL databases. |
| `php7.3-gd` | This package provides support for the GD graphics library in PHP version 7.3, which allows PHP scripts to create and manipulate images. |
| `php7.3-curl` | This package provides support for the cURL library in PHP version 7.3, which allows PHP scripts to make HTTP requests to other servers. |
| `php7.3-xml` | This package provides support for XML in PHP version 7.3, allowing PHP scripts to parse and manipulate XML documents. |
| `php7.3-mbstring` | This package provides support for multibyte string functions in PHP version 7.3, which allows PHP scripts to work with non-ASCII strings. |
| `php7.3-zip` | This package provides support for ZIP archives in PHP version 7.3, allowing PHP scripts to create and manipulate ZIP files. |
| `php7.3-pdo` | This package provides support for the PHP Data Objects (PDO) extension in PHP version 7.3, which allows PHP scripts to interact with various databases using a unified interface. |
| `php7.3-cli` | This package provides the command-line interface (CLI) binary for PHP version 7.3, which allows PHP scripts to be executed from the command line. |

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
#  Setting local_enable to YES allows local users to log in to the FTP server,
# while setting it to NO allows only anonymous users to connect.
local_enable=YES
# ---------------------------------------------------------------------------- #
#  Setting xferlog_enable to YES enables transfer logging, which can be useful 
# for monitoring and auditing file transfer activities on the FTP server.
xferlog_enable=YES
xferlog_file=/dev/stderr
# ---------------------------------------------------------------------------- #
#  Setting connect_from_port_20 to YES enables the use of port 20 for outgoing
# FTP data connections, which can help to avoid issues with firewalls and NAT
# devices.
connect_from_port_20=YES
# ---------------------------------------------------------------------------- #
#  Setting seccomp_sandbox to NO disables the use of the seccomp sandbox for
# the vsftpd process, which may be necessary in some cases but may also increase
# the attack surface of the FTP server.
# seccomp_sandbox=NO
# ---------------------------------------------------------------------------- #
#  Setting write_enable to YES enables write access for authenticated users,
# allowing them to upload files and create directories on the server, while 
# setting it to NO disables write access, preventing users from modifying files
# on the server.
write_enable=YES
# ---------------------------------------------------------------------------- #
#  Setting dirmessage_enable to YES enables the display of directory messages
# when a user changes to a new directory, while setting it to NO disables the
# display of directory messages, potentially improving server performance and
# reducing the risk of revealing sensitive information
dirmessage_enable=YES
# ---------------------------------------------------------------------------- #
#  The local_root directive specifies the local root directory for the FTP
# user. The local root directory is the directory on the server's file system
# that the FTP user will be chrooted to upon logging in to the FTP server.
local_root=/var/www/wordpress
# ---------------------------------------------------------------------------- #
#  Setting chroot_local_user to YES restricts users to their home directories
# and prevents them from accessing other parts of the file system, which can 
# help to improve the security of the server. However, it can also cause issues
# with certain applications or services that require access to files or
# directories outside of the user's home directory.
chroot_local_user=YES
# ---------------------------------------------------------------------------- #
#  Setting allow_writeable_chroot to YES allows users to create and modify
# files within their jailed home directory, which can be useful for certain
# use cases. However, it can also be a security risk, and should be used with
# caution.
allow_writeable_chroot=YES
# ---------------------------------------------------------------------------- #
#  The user_sub_token directive specifies the token that vsftpd should use to
# replace the $USER variable in the local_root setting. By default, the
# local_root setting specifies the path to the root directory for all users.
# However, by using the user_sub_token directive, we can specify a custom
# root directory for each user.
#   For example, if user_sub_token is set to $USER, and a user named "jane"
# logs in to the FTP server, then their custom root directory would be
# /path/to/vsftpd/$USER, which would be equivalent to /path/to/vsftpd/jane.
# user_sub_token=$USER
# ---------------------------------------------------------------------------- #
#  The listen directive is used to specify whether or not vsftpd should listen
# for incoming connections. When set to YES, it enables the use of other
# related directives that allow for further customization of the listening
# behavior of the server.
listen=YES
# ---------------------------------------------------------------------------- #
#  The listen_port directive in an FTP server configuration file specifies the
# port number on which the server listens for incoming connections. By default,
# FTP servers listen on port number 21.
# listen_port=21
# ---------------------------------------------------------------------------- #
#   The listen_address directive in a vsftpd configuration file specifies the
# IP address that the FTP server will listen on for incoming connections.
#   The value 0.0.0.0 is a special address that means "listen on all available
# network interfaces". This means that the server will accept connections on
# any network interface that is configured on the host, including interfaces
# that are accessible from the local network and from the Internet.
listen_address=0.0.0.0
# ---------------------------------------------------------------------------- #
#   The pasv_enable directive is used to enable or disable passive mode for the
# FTP server. In passive mode, the FTP server listens on a range of ports for
# data connections initiated by the FTP client. This is in contrast to active
# mode, where the FTP client listens on a port for data connections initiated
# by the FTP server.
pasv_enable=YES
# ---------------------------------------------------------------------------- #
#   The pasv_address directive in vsftpd configuration specifies the IP address
# that the server will advertise to clients for passive mode data connections.
#   Setting pasv_address to 0.0.0.0 instructs the server to advertise its own
# IP address to clients. This can be useful in situations where the server is
# not behind a NAT gateway and its IP address is reachable by clients.
pasv_address=0.0.0.0
# ---------------------------------------------------------------------------- #
#   The pasv_addr_resolve directive in an FTP server configuration file
# determines whether the server should attempt to resolve the IP address of
# the passive mode data connection.
#   If set to YES, the server will attempt to resolve the IP address of the
# client connected in passive mode. This is useful when the client is located
# behind a NAT (Network Address Translation) router, where the client's IP
# address is not directly accessible from the server.
pasv_addr_resolve=YES
# ---------------------------------------------------------------------------- #
pasv_min_port=10000
# ---------------------------------------------------------------------------- #
pasv_max_port=10100
# ---------------------------------------------------------------------------- #
#   The port_enable directive in vsftpd configuration file determines whether
# the FTP server will accept active FTP connections.
# port_enable=YES
# ---------------------------------------------------------------------------- #
# 
# userlist_enable=YES
# ---------------------------------------------------------------------------- #
# userlist_file=/etc/vsftpd.userlist
# ---------------------------------------------------------------------------- #
#  The "userlist_deny" directive is used to control access to the FTP server
# based on the contents of the "userlist_file", with a value of "YES" denying
# access to listed users and a value of "NO" allowing access to all users by
# default.
# userlist_deny=NO
# ---------------------------------------------------------------------------- #
#   The "secure_chroot_dir" is used to specify the directory for the chroot
# jail for local users, providing an extra layer of security to prevent
# unauthorized access to system files and directories.
secure_chroot_dir=/var/www
# ---------------------------------------------------------------------------- #
#   This directive enables SSL/TLS encryption for FTP connections. When set to
# "YES", the FTP server will require SSL/TLS for all connections. This ensures
# that all data transmitted between the client and server is encrypted and
# cannot be intercepted or read by third parties. To use SSL/TLS, the client
# must also support this feature and be configured to use it. This directive
# requires the OpenSSL library to be installed on the server.
ssl_enable=YES
# ---------------------------------------------------------------------------- #
rsa_cert_file=/etc/ssl/private/vsftpd.crt
# ---------------------------------------------------------------------------- #
rsa_private_key_file=/etc/ssl/private/vsftpd.key
# ---------------------------------------------------------------------------- #
#  Setting anonymous_enable to YES enables anonymous FTP access to the server,
# allowing users to connect without providing a username or password, while
# setting it to NO disables anonymous FTP access, requiring users to
# authenticate before accessing files on the server.
anonymous_enable=NO
# ---------------------------------------------------------------------------- #
#   The "allow_anon_ssl" directive determines whether anonymous users are
# allowed to use SSL/TLS encryption when connecting to the FTP server.
#   Setting it to "NO" helps improve security by preventing potential
# security breaches or unauthorized access to sensitive information.
# allow_anon_ssl=NO
# ---------------------------------------------------------------------------- #
#   The force_local_data_ssl directive forces SSL/TLS encryption for local data
# transfers between the FTP server and client. When set to YES, the FTP server
# will only allow encrypted SSL/TLS connections for local data transfers. This
# helps to ensure the security and privacy of the data being transferred.
# force_local_data_ssl=YES
# ---------------------------------------------------------------------------- #
#   The force_local_logins_ssl directive forces the use of SSL/TLS encryption
# for local logins in the vsftpd FTP server, increasing the security of the
# authentication process.
# force_local_logins_ssl=YES
# ---------------------------------------------------------------------------- #
# 
# ssl_tlsv1=YES
# ---------------------------------------------------------------------------- #
# 
# ssl_sslv2=NO
# ---------------------------------------------------------------------------- #
# 
# ssl_sslv3=NO
# ---------------------------------------------------------------------------- #
# 
# require_ssl_reuse=NO
# ---------------------------------------------------------------------------- #
# 
ssl_ciphers=HIGH
# ---------------------------------------------------------------------------- #
# 
#isolate_network=NO
# ---------------------------------------------------------------------------- #
```

### cAdvisor

### Adminer

### Redis

### Static-Website

