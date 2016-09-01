https://github.com/stefanprodan/aspnetcore-dockerswarm/wiki/RethinkDB-Swarm

https://github.com/hashicorp/vault

### From [the docs](http://doc.akka.io/docs/akka/2.4.9/scala/cluster-usage.html)

```
# Sigar native library extract location during tests.
# Note: use per-jvm-instance folder when running multiple jvm on one host.
akka.cluster.metrics.native-library-extract-folder=${user.dir}/target/native
```
How's the multiple host thing going to work with docker? one vm / container;
need to handle conflict at the host <> container filesystem mapping level.


## sidecar technique
- the sidecar is responsible for managing parameters associated with its client container from the etcd k-v store (e.g. adding and removing the client container from the set of)
- bringing up containers in docker: interior of conatiner wants to see paramters in .conf file that it loads once at init time.
- it is possible to use etcd as a pub/sub => subscribe to changes on a key
- when a parameter (e.g. seed node list) changes, event is delivered to side car contaier whcih examines the key, rewrites the .conf file for its client container, and signals that client container to re-read the .conf file (e.g. with a SIGHUP signal).
