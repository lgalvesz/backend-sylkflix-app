FROM eclipse-temurin:17-jdk-focal

WORKDIR /app

# Copia apenas o necessário primeiro para usar cache
COPY pom.xml ./
COPY src ./src

# Compila o projeto
RUN apt-get update && apt-get install -y maven \
    && mvn clean package -DskipTests \
    && apt-get remove -y maven \
    && rm -rf /var/lib/apt/lists/*

# Copia o JAR gerado para um arquivo fixo
RUN cp target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]