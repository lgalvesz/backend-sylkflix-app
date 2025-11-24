FROM eclipse-temurin:17-jdk-focal AS build

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN apt-get update && apt-get install -y maven \
    && mvn -B -DskipTests clean package


# ======= RUNTIME IMAGE =======
FROM eclipse-temurin:17-jre-focal

WORKDIR /app

COPY --from=build /app/target/backend-sylkflix-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]