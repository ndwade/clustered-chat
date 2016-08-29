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

# TODO: This isn't working.  Next step is to create an explicit network and see about using Docker's
# TODO: published ENV vars to bind things together properly.

# Run each in separate terminals.  Wait 30-45 seconds after each command before running the next one!
docker run --rm -it --publish 9001:9001 --publish 2551:2551 clustered-chat:latest /usr/bin/sbt "run -Dhttp.port=9001 -Dakka.remote.netty.tcp.port=2551 -Dakka.cluster.seed-nodes.0=akka.tcp://application@127.0.0.1:2551 -Dakka.cluster.seed-nodes.1=akka.tcp://application@127.0.0.1:2552 -Dakka.cluster.seed-nodes.2=akka.tcp://application@127.0.0.1:2553"
docker run --rm -it --publish 9002:9002 --publish 2552:2552 clustered-chat:latest /usr/bin/sbt "run -Dhttp.port=9002 -Dakka.remote.netty.tcp.port=2552 -Dakka.cluster.seed-nodes.0=akka.tcp://application@127.0.0.1:2551 -Dakka.cluster.seed-nodes.1=akka.tcp://application@127.0.0.1:2552 -Dakka.cluster.seed-nodes.2=akka.tcp://application@127.0.0.1:2553"
docker run --rm -it --publish 9003:9003 --publish 2553:2553 clustered-chat:latest /usr/bin/sbt "run -Dhttp.port=9003 -Dakka.remote.netty.tcp.port=2553 -Dakka.cluster.seed-nodes.0=akka.tcp://application@127.0.0.1:2551 -Dakka.cluster.seed-nodes.1=akka.tcp://application@127.0.0.1:2552 -Dakka.cluster.seed-nodes.2=akka.tcp://application@127.0.0.1:2553"
```
