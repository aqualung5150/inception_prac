up:
	docker-compose -f ./srcs/docker-compose.yml up --build -d

all: up

down:
	docker-compose -f ./srcs/docker-compose.yml down

clean: vclean iclean

vclean:
	docker volume rm mariadb_volume wordpress_volume

iclean:
	docker image rm mariadb wordpress nginx