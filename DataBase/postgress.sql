\l # for the list of database
\c <database_name> #connects the DB
cltr+L #clear screen in cli DB only

\dt #for the list of tables in DB
\d <DB> #for the columns name
  
CREATE USER sai WITH PASSWORD 'mypassword';
GRANT ALL PRIVILEGES ON DATABASE company TO sai;
server->DB(multiple)->schema(multiple)->Table->columns->rows(data)
row->primary key->data(key-value)

DDL->DML->DQL(select) 

generate_series(1, 100) # to generate numbers in a range

having with group by like after the agretion if you want before the agresgation use where
