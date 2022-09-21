#define base docker image
FROM openjdk:17
MAINTAINER alessia
COPY Libreria.jar libreria-docker.jar
ENTRYPOINT ["java", "-jar", "libreria-docker.jar"]
EXPOSE 8080/tcp