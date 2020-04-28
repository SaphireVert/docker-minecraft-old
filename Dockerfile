ARG REV=1.15.2

# Take ubuntu 20.04 as base image and set stagename as spigotbuild
FROM ubuntu:20.04 AS spigotbuild
ARG REV
ENV REV $REV
ENV DEBIAN_FRONTEND noninteractive
ENV TZ Europe/Zurich


RUN apt update -y && \
    apt upgrade -y
RUN apt install -y \
      git \
      openjdk-11-jdk \
      wget
RUN mkdir -p /spigotdir
WORKDIR /spigotdir
RUN wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN ls -al
RUN java -jar BuildTools.jar --rev $REV


FROM ubuntu:20.04
ARG REV
RUN echo $REV
ENV DEBIAN_FRONTEND noninteractive
ENV TZ Europe/Zurich
RUN apt update -y && \
    apt upgrade -y
RUN apt install -y \
    git \
    openjdk-11-jdk \
    wget
WORKDIR /spigotdir
COPY --from=spigotbuild /spigotdir/spigot-*.jar .
RUN ln -s spigot-$REV.jar spigot.jar
RUN ls -al
CMD ["java", "-jar", "-Xms256M", "-Xmx1G", "spigot.jar"]
