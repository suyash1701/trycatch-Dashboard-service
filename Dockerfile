# ---------- Stage 1: build the jar inside Docker ----------
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests

# ---------- Stage 2: run the jar on a small JRE ----------
FROM eclipse-temurin:17-jre
WORKDIR /usr/app
COPY --from=build /app/target/dashboard-service.jar app.jar
EXPOSE 10002
ENTRYPOINT ["java", "-jar", "app.jar"]