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

## 11. Redis Insight

If Redis is running in Docker locally:

Host: localhost Port: 6379
