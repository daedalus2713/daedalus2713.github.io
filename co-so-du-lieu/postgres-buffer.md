# HOW TO INSTALL POSTGRESQL

## HOW TO INSTALL POSTGRESQL

* Run command:
  * ```bash
    $ sudo apt update
    $ sudo apt install postgresql postgresql-contri
    ```
* Login to PostgreSQL
  * Switch to user postgres:
    * ```bash
      $ sudo -i -u postgres
      ```
  * Login to Postgres:
    * ```bash
      $ psql
      ```
* Create user:
  * ```bash
    $ createuser --interactive --pwpromt
    ```
* Create database:
  * ```bash
    $ createdb -O user dbname
    ```
* Change config to connect by password from localhost
  * locate the pg\_hba.conf file:
    * /etc/postgresql/12/main
  * edit:
    * local all all peer
    * -&gt; local all all md5

## Connect with PGAdmin

* SSH
  * host: local
  * post: 5432
* SSH Tunnel:
  * host: **PUCLIC IP**
  * port: 22 _\(Default for ssh\)_
  * Choose identity file: ssh pem file

