# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <user42@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/12/09 00:10:02 by jlucas-s          #+#    #+#              #
#    Updated: 2024/02/06 22:18:03 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

GREEN		=	\033[1;32m
YELLOW		=	\033[1;33m
RED			=	\033[1;31m
NOCOLOR		=	\033[0m

all:
	@ echo "${GREEN}Creating data directory:${NOCOLOR}"
	sudo mkdir -p /home/${LOGIN}/data/wordpress
	sudo mkdir -p /home/${LOGIN}/data/mariadb
	@ echo ""

	@ echo "${GREEN}Upping Docker compose:${NOCOLOR}"
	docker compose -f ./srcs/docker-compose.yml up -d --build
	@ echo ""

down:
	@ echo "${RED}Downing Docker compose:${NOCOLOR}"
	docker compose -f ./srcs/docker-compose.yml down
	@ echo ""

clean: down
	@ echo "${RED}Docker remove images:${NOCOLOR}"
	@ docker rmi -f $$(docker images | grep inception | awk '{print $$3}')
	@ echo ""

	@ echo "${RED}Docker remove volumes:${NOCOLOR}"
	@ docker volume rm inception_mariadb inception_wordpress
	@ echo ""

	@ echo "${RED}Removing data directory:${NOCOLOR}"
	sudo rm -rf /home/${LOGIN}/data
	@ echo ""

re: clean all

.PHONY: all down clean re