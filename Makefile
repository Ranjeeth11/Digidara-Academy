# Makefile
.PHONY: up down build restart logs clean

up:
	docker-compose up -d

down:
	docker-compose down

build:
	docker-compose build --no-cache

restart:
	docker-compose restart

logs:
	docker-compose logs -f

clean:
	docker-compose down -v
	docker system prune -f

moodle-logs:
	docker-compose logs -f moodle

ai-logs:
	docker-compose logs -f ai-service

db-shell:
	docker-compose exec db mysql -u root -prootpass moodle

ai-shell:
	docker-compose exec ai-service bash

moodle-shell:
	docker-compose exec moodle bash

test:
	docker-compose exec ai-service python -m pytest

format:
	docker-compose exec ai-service black src/
	docker-compose exec ai-service ruff src/ --fix