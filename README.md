# Database Migration with Golang Migrate

## Installation
```bash
# Golang version
$ go version
go version go1.20.6 linux/amd64

# Linux version
$ lsb_release -a
...
Description:    Ubuntu 20.04.6 LTS
Release:        20.04
...

# Install golang-migrate
# https://github.com/golang-migrate/migrate/tree/v4.17.0/cmd/migrate
# Linux (*.deb package)
$ curl -L https://packagecloud.io/golang-migrate/migrate/gpgkey | apt-key add -
$ echo "deb https://packagecloud.io/golang-migrate/migrate/ubuntu/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/migrate.list
$ apt-get update
$ apt-get install -y migrate

# golang-migrate version
$ /usr/bin/migrate --version
4.17.0
```

## Create Demo Database Remotely
```bash
$ psql -h 192.168.1.5 -p 5432 -U postgres

# Creating a database for demo purposes
$ postgres=# CREATE DATABASE db_migration_demo

# Check the list of databases
$ postgres-# \l
                                                  List of databases
         Name         |  Owner   | Encoding |        Collate         |         Ctype          |   Access privileges   
----------------------+----------+----------+------------------------+------------------------+-----------------------
 db_migration_demo    | postgres | UTF8     | English_Indonesia.1252 | English_Indonesia.1252 | 

# exit
$ postgres-# \q
```
## Create Database Migration
```bash
# Create table products
$ /usr/bin/migrate create -ext sql -dir db/migrations create_table_products
.../db/migrations/20240408154912_create_table_products.up.sql
.../db/migrations/20240408154912_create_table_products.down.sql
```

20240408154912_create_table_products.up.sql
```sql
-- CREATE SEQUENCE
CREATE SEQUENCE product_id_seq START 1;

-- CREATE TABLE
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    status VARCHAR(1) DEFAULT '1',
    created_at TIMESTAMP DEFAULT now(),
    name VARCHAR(255) DEFAULT NULL,
    image VARCHAR(255) DEFAULT NULL,
    price NUMERIC(10,2) DEFAULT NULL,
    qty INTEGER
);

-- INSERT
...
```

20240408154912_create_table_products.down.sql
```sql
DROP SEQUENCE IF EXISTS product_id_seq;
DROP TABLE IF EXISTS products;
```

## Run Migration
Check out https://stedolan.github.io/jq/

```bash
$ /usr/bin/migrate -source file:db/migrations -database "$(cat config.json | jq -r '.DatabaseMigration')" up
20240408154912/u create_table_products (46.281685ms)
```

## Check Table after Migration
```bash
$ psql -h 192.168.1.5 -p 5432 -U postgres
$ postgres=# \c db_migration_demo
$ db_migration_demo=# \dt
               List of relations
 Schema |       Name        | Type  |  Owner   
--------+-------------------+-------+----------
 public | products          | table | postgres
 public | schema_migrations | table | postgres
```

## Troubleshooting

```
error: Dirty database version 20240408162752. Fix and force version
```
For solution, check out https://www.youtube.com/watch?v=jJp2S4O3stM