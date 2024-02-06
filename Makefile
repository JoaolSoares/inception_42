# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <user42@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/12/09 00:10:02 by jlucas-s          #+#    #+#              #
#    Updated: 2024/02/06 15:53:32 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

GREEN		=	\033[1;32m
YELLOW		=	\033[1;33m
RED			=	\033[1;31m
NOCOLOR		=	\033[0m

all:
	@ echo "${GREEN}Creating data directory:"
	sudo mkdir -p /home/${LOGIN}/data/wordpress
	sudo mkdir -p /home/${LOGIN}/data/mariadb
	@ echo "${NOCOLOR}\n"

	@ echo "${GREEN}Upping Docker compose:${NOCOLOR}"
	docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@ echo "${RED}Downing Docker compose:${NOCOLOR}"
	docker compose -f ./srcs/docker-compose.yml down

clean:
	@ echo "${RED}Docker stop containers:${NOCOLOR}" 	
	@ docker stop $$(docker ps -qa)					
	@ echo "${RED}Docker remove containers:${NOCOLOR}"	
	@ docker rm $$(docker ps -qa)						
	@ echo "${RED}Docker remove images:${NOCOLOR}"
	@ docker rmi -f $$(docker images -qa)		
	@ echo "${RED}Docker remove volumes:${NOCOLOR}"	
	@ docker volume rm $$(docker volume ls -q)			
	@ echo "${RED}Docker remove networks:${NOCOLOR}"	
	@ docker network rm inception			
	@ echo "${RED}Removing data directory:${NOCOLOR}"	
	sudo rm -rf /home/${LOGIN}/data

re: clean all

.PHONY: all down clean re