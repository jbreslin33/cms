java -jar src/database/schemaSpy.jar -t pgsql -host localhost -db cms -u postgres -p mibesfat -o erm -s public -dp src/database/postgresql.jar
firefox erm/index.html
