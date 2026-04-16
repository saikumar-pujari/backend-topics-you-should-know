## persistance
its to load the data from the DB when the services starts.
its configured in the `save` in the file .conf.
>save

>config get save
output:
```
1) "save"
2) "3600 1 300 100 60 10000"
```
>config set save '120 1'
#### it means write in drive every 120 sec for every 1 change

> the file is saved in /data/dump.rdb file

<br>
or else you can even add AOF(appendonlyfile) which appends all the activity of your data(may cause or loose 1sec of data) step by step.
>config get appendfile

for default its `save` we can set it ```yes``` using `config set appendfile yes`
> the file is saved in /data/appendfile/ file

<hr>

## master and slave

to make a server slave use `replicaof <server_name> <port>`(replicaof my-redis 6379)
check it using the `info replication` and check the master_link_status:up, role:slave and master_host:my-redis

<hr>

## Sentinel
  it will detech the fail over in the master and upgrade any one of the slave as their master with max voting between them!
  they use the PORT 26379 and so on 

  sentinal.conf
  ```
  port 26379
  sentinel monitor mymaster 127.0.0.1 6379 1
  sentinel down-after-milliseconds mymaster 5000
  sentinel failover-timeout mymaster 10000
  sentinel parallel-syncs mymaster 1
  ```

  > then when we start a master and slave in new terminal try `SENTINEL get-master-addr-by-name mymaster` you will get the MASTER name and PORT_NUMBER

  onces the master is down it will automatically prompt the slave to master as per the votings
