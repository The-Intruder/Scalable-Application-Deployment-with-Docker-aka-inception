# Inception

## Project Description

## Tasks

1. The whole project has to be done in a virtual machine.
2. You have to use `docker compose`.
3. Each Docker image must have the same name as its corresponding service.
4. Each service has to run in a dedicated container.
5. The containers must be built ~~either~~ from ~~the penultimate stable version of Alpine or~~ `Debian`.
6. You have to write your own `Dockerfiles`, one per service. I.e. you have to build yourself the Docker images of your project.
7. The `Dockerfiles` must be called in your `docker-compose.yml` by your `Makefile`.
8. It is **forbidden** to pull *ready-made Docker images*, as well as using services such as `DockerHub` *(Alpine/Debian being excluded from this rule)*

## Things to set up

### Mandatory Part

1. A *Docker container* that contains **NGINX** with *TLSv1.2* or *TLSv1.3* only.
2. A *Docker container* that contains **WordPress** + **php-fpm** *(it must be installed and configured)* only *without nginx*.
3. A *Docker container* that contains **MariaDB** only *without nginx*.
4. A *volume* that contains your **WordPress database**.
5. A *second volume* that contains your **WordPress website files**.
6. A `docker-network` that establishes the connection between your containers.
7. In your WordPress database, there must be two users, one of them being the administrator.
  a. The administrator’s username can’t contain admin/Admin or administrator/Administrator (e.g., admin, administrator, Administrator, admin-123, and so forth).
8. Your volumes will be available in the `/home/login/data` folder of the host machine using Docker. Of course, you have to replace the login with yours.
9. You have to configure your domain name so it points to your local IP address. This domain name must be `login.42.fr`. I.e. you have to use your own login. E.g. if your login is `wil`, `wil.42.fr` will redirect to the IP address pointing to `wil`’s website.

#### Notes

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

#### Notes

- To complete the bonus part, you have the possibility to set up extra services. In this case, you may open more ports to suit your needs.
