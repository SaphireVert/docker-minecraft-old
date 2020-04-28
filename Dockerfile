# Set the default REV value
ARG REV=latest

# Take ubuntu 20.04 as base image and set stagename as spigotbuild
FROM ubuntu:20.04 AS spigotbuild
# Use the REV specified by --build-arg if present, otherwise take the default
ARG REV
RUN echo "Building spigot for rev=$REV"
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
ENV REG $REV
RUN echo $REV
ENV DEBIAN_FRONTEND noninteractive
ENV TZ Europe/Zurich
RUN apt update -y && \
    apt upgrade -y
RUN apt install -y \
    git \
    openjdk-11-jdk \
    wget
RUN apt clean && apt autoremove
WORKDIR /spigotdir
COPY --from=spigotbuild /spigotdir/spigot-*.jar .
RUN ln -s spigot-$REV.jar spigot.jar
ADD ./spigot.sh /spigot.sh
RUN chmod +x /spigot.sh
RUN ls -al
CMD ["/spigot.sh"]
# CMD ["java", "-jar", "-Xms256M", "-Xmx1G", "spigot.jar"]
