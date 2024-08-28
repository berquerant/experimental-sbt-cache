FROM experimental-sbt-cache-sbt

WORKDIR /app

# copy app sources
COPY build.sbt /app
COPY src/ /app/src
COPY project/ /app/project
# copy caches
COPY target/ /app/target
COPY cache/ /app/cache
COPY .cache/ /root/.cache

RUN ls -al /app /app/project /app/project/target /app/target /root /root/.cache

ARG SBT_BASE
ARG IVY_HOME
ARG CS_HOME
ARG BOOTD

# https://www.scala-sbt.org/1.x/docs/Command-Line-Reference.html#Other+system+properties
ENV SBT_OPTS="-Dsbt.global.base=${SBT_BASE} -Dsbt.ivy.home=${IVY_HOME} -Dsbt.coursier.home=${CS_HOME} -Dsbt.boot.directory=${BOOTD}"
# cached?
RUN sbt compile -v
