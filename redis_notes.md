# Redis Complete Notes

## 1. Publish / Subscribe (Pub/Sub)

Redis provides a **Publish--Subscribe messaging system** where:

-   **Publisher** → sends messages to a channel
-   **Subscriber** → listens to a channel and receives messages

Example publish: PUBLISH chat_room "Hello Everyone"

Subscribe: SUBSCRIBE chat_room

Pattern subscribe: PSUBSCRIBE news\*

Count subscribers: PUBSUB NUMSUB chat_room

------------------------------------------------------------------------

## 2. Persistence

Redis supports persistence to disk.

Configuration file: sudo nano redis.conf

Snapshot rules:

save 3600 1 save 300 100 save 60 10000

Meaning:

save 3600 1 → save if 1 key changed in 3600 seconds\
save 300 100 → save if 100 keys changed in 5 minutes\
save 60 10000 → save if 10000 keys changed in 60 seconds

Check configuration: CONFIG GET save

------------------------------------------------------------------------

## 3. Key Commands

Delete everything: FLUSHALL

List all keys: KEYS \*

------------------------------------------------------------------------

## 4. Replication (Master / Replica)

Configure master in redis.conf:

bind 0.0.0.0 protected-mode no

Configure replica:

replicaof `<master_ip>`{=html} `<port>`{=html}

Example: replicaof 192.168.1.10 6379

Check replication: INFO replication

Convert slave → master: REPLICAOF NO ONE

Convert master → slave: REPLICAOF ip port

------------------------------------------------------------------------

## 5. Redis Sentinel

Sentinel monitors Redis nodes and automatically promotes slaves to
master during failover.

------------------------------------------------------------------------

## 6. Redis Cluster

Redis cluster allows horizontal scaling.

Key facts:

-   Uses 16384 hash slots
-   Keys distributed across nodes
-   Minimum 3 masters required

Enable cluster in redis.conf:

cluster-enabled yes cluster-config-file nodes.conf cluster-node-timeout
5000

Check nodes:

redis-cli -p 7000 cluster nodes

Filter masters:

redis-cli -p 7000 cluster nodes \| grep master

------------------------------------------------------------------------

## 7. Redis Transactions

Commands:

MULTI → start transaction\
EXEC → execute transaction\
DISCARD → cancel transaction\
WATCH → monitor keys

Example:

MULTI INCRBY counter 10 DECRBY counter 2 EXEC

------------------------------------------------------------------------

## 8. Streams

Streams are an append-only data structure similar to pub/sub but with
persistence.

------------------------------------------------------------------------

## 9. Cache

Example:

redis.set("key","value") redis.get("key")

------------------------------------------------------------------------

## 10. ACL (Access Control List)

Commands:

ACL LIST ACL WHOAMI ACL GETUSER default

Authentication: AUTH username password

Create user:

ACL SETUSER sai on \>saikumar allkeys +get +set

Delete user:

ACL DELUSER sai

Generate password:

ACL GENPASS

------------------------------------------------------------------------
>publish and subscriber like publish channel_name "msg" and subscriber channel_name

>patter based psubscribed channel_name(* means any)

>to count the subsribe use pubsub numsub channel_name
>persistence data-config_settings(sudo nano redis.conf)-snapshotting-save"" save 3600 1 300 100 60 10000(config get save)--also can change the port number if needed

>flush_all

>keys *

>to make it master server we need to make the bind as commented and procted as no and copy the password from the .config also in the replica server make the replica and uncomment and give rhe ip of master and port_no

>to get the info of the server use (info replication)

>to convert back salve to master use (replicaof no one) and back to slave (replicaof ip port)

>sentinel(automatically promort salves to master when master failover)

>redis cluster->redis is scaled horizontally using development toplogy and it provides automatically data is sharding

>it spilits your dataset aming muktiple set and it works when the subset nodes are not able to communicate with eachother

>it uses a hashslot(16384 slots in cluster)

>atleast 3 masters are needed to make a cluster

>cluster_seeting should be copied from the official docs

>check the cluster nodes by (redis-cli -p which_port cluster nodes and (| grep master))

>we can automatically create it by command create-cluster | (start and run and delete)

>redis-transcation->excutes a group of command(multi,exec,discard,watch)

>man see first we need to enter multi next prompt will  have a TX with it means wating for the queue and enter your command like incrby or decr by then atlast enter exec to complete query and when we want to come out enter discard

>when we want to close see like there might be a failure chance in account we can watch it man by (watch account:saikumar) if execution fails it will return nil or runs the query

>STREAM:->append only data structre eg:pub-sub

>cache->redis.set("key","value") redis.get("key")

>ACL-> ACL list,acl whoami,acl getuser default,auth username passwors,acl setuser sai(name) on >saikumar(password) -allcommands allkeys( nocommands -set +get),acl deluser sai(name),acl genpass(password generate)

>eset,mset,mget,ex,px,perists,exprie,type,exists,eval,incrby


>redis-insight: if using in local like docker then host is localhost


