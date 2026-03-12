JSON+metadata=document
in json format
in form of _index,_source.etc(data keys save in in this format)
doc=row in sql
fields=columns in sql
index =table in sql
nodes,cluster
document are grouped by indices
KIBANA(its a mostly a API's work man!!)
query or restAPI's to get data
if we want we can use the local hosthost queryset 
also in CMD using CURL -k(no security)
sharding(divind the incides into smaller part) improves tthe performances by paralleization of quires
limit 2 billion documents for sharding
sharding is done by split and shrink API's
replication just keeps the copy of a index
replication group is where the replicated data dna original data is kept together(primary shard orginal field)
get_refresh_token(2 nodes)
