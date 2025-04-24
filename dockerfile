FROM openjdk:17
COPY target/Dashboard-service.jar /usr/app
WORKDIR /usr/app
ENTRYPOINT ["java","-jar","Dashboard-service.jar"]