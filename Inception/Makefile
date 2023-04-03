# **************************************************************************** #
# ***************************    COLOR CODES    ****************************** #
# **************************************************************************** #

RST			:= \e[0m
RED			:= \e[31m
GRN			:= \e[32m
YLW			:= \e[33m
CYN			:= \e[36m

# **************************************************************************** #
# ****************************    FUNCTIONS    ******************************* #
# **************************************************************************** #

define print_status
    @printf "$1$2\e[0m\n"
endef

# **************************************************************************** #
# *****************************    RECIPES    ******************************** #
# **************************************************************************** #

.PHONY: all clean fclean re start a-stop m-stop

all: m-stop start

start:
	@sudo docker-compose up --build
	$(call print_status, ${GRN}, "Auto-Start has been performed successfully")

a-stop:
	@sudo docker-compose down
	$(call print_status, ${YLW}, "Auto-Halt has been performed successfully")

m-stop:
	@sudo docker stop `sudo docker ps -aq`
	$(call print_status, ${YLW}, "Manual-Halt has been performed successfully")

clean:
	@sudo docker rm -f `sudo docker ps -aq`
	$(call print_status, ${RED}, "Containers deleted successfully")

fclean: clean
	@sudo docker rmi -f `sudo docker images -q`
	$(call print_status, ${RED}, "Images deleted successfully")

re: fclean all

reset:
	$(call print_status, ${YLW}, "Stopping all the currently running continers ...")
	@-sudo docker stop `sudo docker ps -aq`
	$(call print_status, ${RED}, "Deleting all the cache in docker ...")
	@echo 'y' | sudo docker system prune -a
	$(call print_status, ${RED}, "Removing the ~/data folder ...")
	@sudo rm -rf /home/mnaimi/data
	$(call print_status, ${GRN}, "Making the ~/data/wordpress folder ...")
	@mkdir -p /home/mnaimi/data/wordpress
	$(call print_status, ${GRN}, "Making the ~/data/mariadb folder ...")
	@mkdir -p /home/mnaimi/data/mariadb
	$(call print_status, ${CYN}, "Running all the containers ...")
	@sudo docker-compose -f srcs/docker-compose.yml -p Inception up --build

# Connect the FTP to the wordpress ontainer ONLY
# Delete the volumes
# Check the evaluation pdf
