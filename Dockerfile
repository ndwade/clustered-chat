#
# Scala and sbt Dockerfile
#
# https://github.com/hseeberger/scala-sbt
#

# Pull base image
FROM java:8

# NOTE: Keep these in sync with the actual sbt config, or you'll have painful build times!
ENV SCALA_VERSION 2.11.8
ENV SBT_VERSION 0.13.11

# Install Scala
## Piping curl directly in tar
RUN \
  curl -fsL http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo 'export PATH=~/scala-$SCALA_VERSION/bin:$PATH' >> /root/.bashrc

# Install sbt
RUN \
  curl -L -o sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt && \
  sbt sbtVersion

# Define working directory
RUN mkdir -p /app/project/target
WORKDIR /app

COPY *.sbt /app
COPY project/*.sbt /app/project
COPY project/*.properties /app/project

RUN sbt clean update

COPY . /app

RUN sbt compile

EXPOSE 9000

CMD ["sbt", "run"]

