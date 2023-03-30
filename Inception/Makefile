# **************************************************************************** #
# ***************************    COLOR CODES    ****************************** #
# **************************************************************************** #

RST			:= \e[0m
RED			:= \e[31m
GRN			:= \e[32m
YLW			:= \e[33m
CYN			:= \e[36m

# **************************************************************************** #
# ***************************    COMPILATION   ******************************* #
# **************************************************************************** #

CC			:= c++
CC_FLAGS	:= -Wall -Wextra -Werror -Wno-shadow -std=c++98

NAME		:= MutantStack
MAIN		:= main.cpp
HEAD		:= MutantStack.hpp

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
	@docker-compose up --build
	$(call print_status, ${GRN}, "Auto-Start has been performed successfully")

a-stop:
	@docker-compose down
	$(call print_status, ${YLW}, "Auto-Halt has been performed successfully")

m-stop:
	@docker stop $(docker ps -aq)
	$(call print_status, ${YLW}, "Manual-Halt has been performed successfully")

clean:
	@docker rm -f $(docker ps -aq)
	$(call print_status, ${RED}, "Containers deleted successfully")

fclean: clean
	docker rmi -f $(docker images -q)
	$(call print_status, ${RED}, "Images deleted successfully")

re: fclean all

# Connect the FTP to the wordpress ontainer ONLY
# Delete the volumes
# Check the evaluation pdf
