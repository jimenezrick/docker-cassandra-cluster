FROM ubuntu
MAINTAINER Ricardo Catalinas <ricardo.catalinas@bigdatapartnership.com>

ENV TERM linux

# Install Java
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >/etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y curl

# Preemptively accept the Oracle License and install the JDK
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN apt-get install -y oracle-java8-installer oracle-java8-set-default

# Install Cassandra
RUN echo "deb http://debian.datastax.com/community stable main" >/etc/apt/sources.list.d/datastax.list
RUN curl -L http://debian.datastax.com/debian/repo_key | apt-key add -
RUN apt-get update
#RUN apt-get install -y dsc12=1.2.16-1 cassandra=1.2.16
RUN apt-get install -y dsc20
RUN apt-get clean

ADD cassandra-start /usr/sbin/
RUN chown root:root /usr/sbin/cassandra-start
RUN chmod 755 /usr/sbin/cassandra-start

# Storage port, encrypted storage, JMX, Thrift, CQL Native
EXPOSE 7000 7001 7199 9160 9042

VOLUME ["/var/lib/cassandra", "/var/log/cassandra"]

CMD cassandra-start
