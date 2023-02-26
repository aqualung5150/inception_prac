up:
	sudo mkdir -p ${HOME}/data/mariadb ${HOME}/data/wordpress ${HOME}/data/adminer ${HOME}/data/prometheus

ifeq (,$(wildcard .host_setup))
	@echo "Add seunchoi.42.fr to /etc/hosts."
	sudo chmod 777 /etc/hosts
	sudo echo "127.0.0.1 seunchoi.42.fr" >> /etc/hosts
	touch .host_setup
else
	@echo "seunchoi.42.fr exists in /etc/hosts."
endif

	docker compose -f ./srcs/docker-compose.yml up --build -d

all: up

down:
	docker compose -f ./srcs/docker-compose.yml down

re:
	docker compose -f ./srcs/docker-compose.yml down
	docker compose -f ./srcs/docker-compose.yml up --build -d

vclean:
	docker volume rm mariadb_volume wordpress_volume adminer_volume prometheus_volume
	sudo rm -rf ${HOME}/data
iclean:
	docker image rm mariadb wordpress nginx redis ftp adminer my-page grafana prometheus cadvisor

.PHONY: up all down re vclean iclean