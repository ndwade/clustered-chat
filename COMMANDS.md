# Workflow Quick-Reference

## Local Cluster, no Docker

```bash
# Run each in separate terminals.  Wait 30-45 seconds after each command before running the next one!
sbt "run -Dhttp.port=9001 -Dakka.remote.netty.tcp.port=2551 -Dakka.cluster.seed-nodes.0=akka.tcp://application@127.0.0.1:2551 -Dakka.cluster.seed-nodes.1=akka.tcp://application@127.0.0.1:2552 -Dakka.cluster.seed-nodes.2=akka.tcp://application@127.0.0.1:2553"
sbt "run -Dhttp.port=9002 -Dakka.remote.netty.tcp.port=2552 -Dakka.cluster.seed-nodes.0=akka.tcp://application@127.0.0.1:2551 -Dakka.cluster.seed-nodes.1=akka.tcp://application@127.0.0.1:2552 -Dakka.cluster.seed-nodes.2=akka.tcp://application@127.0.0.1:2553"
sbt "run -Dhttp.port=9003 -Dakka.remote.netty.tcp.port=2553 -Dakka.cluster.seed-nodes.0=akka.tcp://application@127.0.0.1:2551 -Dakka.cluster.seed-nodes.1=akka.tcp://application@127.0.0.1:2552 -Dakka.cluster.seed-nodes.2=akka.tcp://application@127.0.0.1:2553"
```
