FROM openjdk:11
COPY /build/libs/demo-0.0.1-SNAPSHOT.jar /kubernetes-demo/application.jar
CMD [ "java", "-jar", "/kubernetes-demo/application.jar" ]
LABEL maintainer="whoever@gmail.com"