psqlup:
	docker run --name psqldb -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:latest

psqldown:
	docker stop psqldb

psqlrm:
	docker rm psqldb

createdb:
	docker exec -it psqldb createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it psqldb dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" --verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" --verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: psqlup psqldown createdb dropdb migrateup migratedown test