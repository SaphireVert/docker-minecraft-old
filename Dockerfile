# Set the default REV value
ARG REV=latest
# Set the default installation dir
ARG SPIGOTDIR=/minecraft

# First stage
FROM ubuntu:20.04 AS spigotbuild
# Use the REV specified by --build-arg if present, otherwise take the default
ARG REV
ARG SPIGOTDIR
RUN echo "Building spigot for rev=$REV"
ENV DEBIAN_FRONTEND noninteractive
ENV TZ Europe/Zurich

RUN apt update -y && \
    apt upgrade -y
RUN apt install -y \
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
ARG SPIGOTDIR
ARG XMS
ARG XMX
ENV REG $REV
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

WORKDIR $SPIGOTDIR
COPY --from=spigotbuild $SPIGOTDIR/spigot-*.jar .
RUN ln -s spigot-$REV.jar spigot.jar
ADD ./spigot.sh /spigot.sh
RUN chmod +x /spigot.sh

EXPOSE 25565
EXPOSE 8123

CMD ["/spigot.sh"]
# CMD ["java", "-jar", "-Xms256M", "-Xmx1G", "spigot.jar"]
