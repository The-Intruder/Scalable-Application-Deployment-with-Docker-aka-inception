# **************************************************************************** #
# *****************************    RECIPES    ******************************** #
# **************************************************************************** #

.PHONY: all clean fclean re start stop force-stop

all: start

start:
	@sudo docker-compose -f srcs/docker-compose.yml up --build

stop:
	@sudo docker-compose -f srcs/docker-compose.yml down

force-stop:
	@sudo docker stop `sudo docker ps -aq`

clean:
	@-sudo docker stop `sudo docker ps -qa`
	@-sudo docker rm `sudo docker ps -qa`
	@-sudo docker rmi -f `sudo docker images -qa`
	@-sudo docker volume rm `sudo docker volume ls -q`
	@-sudo docker network rm `sudo docker network ls -q`
	@sudo rm -rf /home/mnaimi/data
	@mkdir -p /home/mnaimi/data/wordpress
	@mkdir -p /home/mnaimi/data/mariadb

fclean: clean
	@echo 'y' | sudo docker system prune -a

re: fclean all

# **************************************************************************** #

mac-start:
	@docker-compose -f srcs/docker-compose.yml up --build

mac-stop:
	@docker-compose -f srcs/docker-compose.yml down

mac-force-stop:
	@docker stop `docker ps -aq`

mac-clean:
	@-docker stop `docker ps -qa`
	@-docker rm `docker ps -qa`
	@-docker rmi -f `docker images -qa`
	@-docker volume rm `docker volume ls -q`
	@-docker network rm `docker network ls -q`
	@rm -rf ~/data
	@mkdir -p ~/data/wordpress
	@mkdir -p ~/data/mariadb

mac-fclean: mac-clean
	@echo 'y' | docker system prune -a

mac-re: mac-fclean mac-start
