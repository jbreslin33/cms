sudo -u postgres createdb cms
sudo -u postgres psql -d cms -f src/db/build.sql
