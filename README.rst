Docker Cassandra Cluster
========================

Standalone/clustered DataStax Community running on top of a Ubuntu
Docker image.

Building the image
------------------

For your convenience you can use the ``build.sh`` script that invokes
the standard Docker command.

Running as a single node
------------------------

You can run the image directly as you would do with any other one::

	docker run cassandra-cluster

The necessary ports are exposed, so you can interact with the Docker
container as you normally would do.

Running a cluster
-----------------

If you want to start a cluster with any number of nodes, it's as simple
as using one of the two helper scripts provided specifying the number of
nodes you want::

	scripts/run-cassandra-cluster <nodes>

After creating the containers of the cluster, you will see that the file
``cassandra-nodes`` is created in your current directory. This file
contains the IDs of all those containers so that when you want to stop
the cluster you can run the next command with the file in the same
location::

	scripts/run-cassandra-cluster stop

After you have created the cluster, you can create a new container with
all the Cassandra tools but without running the server. You can do this
with the other script specifying the number of the node you want to be
linked with::

	scripts/run-cassandra-client <node>

When you enter in the client container, you have direct access to the
directories where the selected Cassandra node is writing such as::

	/var/lib/cassandra
	/var/log/cassandra

Although the client container is linked to one of the Cassandra nodes to
inspect its disk, the client container has network access to all the
nodes of the cluster.

Choosing a specific Cassandra release
-------------------------------------

The default ``Dockerfile`` pulls a recent release of Cassandra, modify
the install directive with the specific version you need and rebuild the
image.
