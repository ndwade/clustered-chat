# Workflow Quick-Reference

## Local Cluster, no Docker

```bash
# Run each in separate terminals.  Wait 30-45 seconds after each command before running the next one!
sbt "run -Dhttp.port=9001 -Dakka.remote.netty.tcp.port=2551 -Dakka.cluster.seed-nodes.0=akka.tcp://application@127.0.0.1:2551 -Dakka.cluster.seed-nodes.1=akka.tcp://application@127.0.0.1:2552 -Dakka.cluster.seed-nodes.2=akka.tcp://application@127.0.0.1:2553"
sbt "run -Dhttp.port=9002 -Dakka.remote.netty.tcp.port=2552 -Dakka.cluster.seed-nodes.0=akka.tcp://application@127.0.0.1:2551 -Dakka.cluster.seed-nodes.1=akka.tcp://application@127.0.0.1:2552 -Dakka.cluster.seed-nodes.2=akka.tcp://application@127.0.0.1:2553"
sbt "run -Dhttp.port=9003 -Dakka.remote.netty.tcp.port=2553 -Dakka.cluster.seed-nodes.0=akka.tcp://application@127.0.0.1:2551 -Dakka.cluster.seed-nodes.1=akka.tcp://application@127.0.0.1:2552 -Dakka.cluster.seed-nodes.2=akka.tcp://application@127.0.0.1:2553"
```


## Docker, Single-Host

```bash
docker build -t clustered-chat:latest .

docker network create --driver bridge clustered-chat

# Run each in separate terminals.  Wait 30-45 seconds after each command before running the next one!
docker run --rm -it \
  --publish 9001:9001 --publish 2551:2551 --network clustered-chat --ip 172.19.0.2 \
  clustered-chat:latest \
  /usr/bin/sbt "run -Dhttp.port=9001 -Dakka.remote.netty.tcp.port=2551 \
    -Dakka.remote.netty.tcp.hostname=172.19.0.2 -Dakka.remote.netty.tcp.bind-port=2551 \
    -Dakka.cluster.seed-nodes.0=akka.tcp://application@172.19.0.2:2551 \
    -Dakka.cluster.seed-nodes.1=akka.tcp://application@172.19.0.3:2552 \
    -Dakka.cluster.seed-nodes.2=akka.tcp://application@172.19.0.4:2553"

docker run --rm -it \
  --publish 9002:9002 --publish 2552:2552 --network clustered-chat --ip 172.19.0.3 \
  clustered-chat:latest \
    /usr/bin/sbt "run -Dhttp.port=9002 -Dakka.remote.netty.tcp.port=2552 \
    -Dakka.remote.netty.tcp.hostname=172.19.0.3 -Dakka.remote.netty.tcp.bind-port=2552 \
    -Dakka.cluster.seed-nodes.0=akka.tcp://application@172.19.0.2:2551 \
    -Dakka.cluster.seed-nodes.1=akka.tcp://application@172.19.0.3:2552 \
    -Dakka.cluster.seed-nodes.2=akka.tcp://application@172.19.0.4:2553"

docker run --rm -it \
  --publish 9003:9003 --publish 2553:2553 --network clustered-chat --ip 172.19.0.4 \
  clustered-chat:latest \
  /usr/bin/sbt "run -Dhttp.port=9003 -Dakka.remote.netty.tcp.port=2553 \
    -Dakka.remote.netty.tcp.hostname=172.19.0.4 -Dakka.remote.netty.tcp.bind-port=2553 \
    -Dakka.cluster.seed-nodes.0=akka.tcp://application@172.19.0.2:2551 \
    -Dakka.cluster.seed-nodes.1=akka.tcp://application@172.19.0.3:2552 \
    -Dakka.cluster.seed-nodes.2=akka.tcp://application@172.19.0.4:2553"
```
