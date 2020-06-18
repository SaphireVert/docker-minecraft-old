# Set the default REV value
ARG REV=latest
# Set the default installation dir
ARG TEMPDIR=/tmpmineserv
ARG SPIGOTDIR=/minecraft

# First stage
FROM ubuntu:20.04 AS spigotbuild
# Use the REV specified by --build-arg if present, otherwise take the default
ARG REV
ARG SPIGOTDIR
ARG FORCE_DOWNLOAD_SPIGOT
# if [ FORCE_DOWNLOAD_SPIGOT=true or ]
RUN echo "Building spigot for rev=$REV"
ENV DEBIAN_FRONTEND noninteractive
ENV TZ Europe/Zurich

RUN apt-get update -y
RUN apt-get install -y \
        git \
        openjdk-11-jdk \
        wget

RUN mkdir -p $SPIGOTDIR
WORKDIR $SPIGOTDIR
RUN wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN ls -al
RUN java -jar BuildTools.jar --rev $REV


# Second stage
FROM ubuntu:20.04
ARG REV
ARG TEMPDIR
ARG SPIGOTDIR
ARG XMS
ARG XMX
ENV REV $REV
ENV TEMPDIR $TEMPDIR
ENV SPIGOTDIR $SPIGOTDIR
ENV XMS $XMS
ENV XMX $XMX
ENV DEBIAN_FRONTEND noninteractive
ENV TZ Europe/Zurich

RUN apt update -y && \
    apt upgrade -y
RUN apt install -y \
    git \
    openjdk-11-jdk \
    wget
RUN apt clean && apt autoremove

WORKDIR $TEMPDIR
COPY --from=spigotbuild $SPIGOTDIR/spigot-$REV.jar /spigot/spigot.jar
# RUN ln -s /spigot/spigot-$REV.jar $SPIGOTDIR/spigot.jar
RUN echo "spigot 2020-06-18_16:17:34"
ADD ./spigot.sh /spigot.sh
ADD ./server.properties /tmpmineserv/server.properties
ADD ./spigot.yml /tmpmineserv/spigot.yml
RUN chmod +x /spigot.sh

EXPOSE 25565
EXPOSE 8123

CMD ["/spigot.sh"]
# CMD ["java", "-jar", "-Xms256M", "-Xmx1G", "spigot.jar"]
