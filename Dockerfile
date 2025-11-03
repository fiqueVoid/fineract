# -------- Stage 1: Build the JAR --------
FROM gradle:8.0.2-jdk17 AS builder
WORKDIR /fineract/fineract
COPY . .

RUN ./gradlew :fineract-provider:bootJar

# -------- Stage 2: Run the app --------
FROM openjdk:17-jdk-slim
WORKDIR /usr/src/app_core

COPY --from=builder /app/fineract-provider/build/libs/fineract-provider-*.jar app.jar

EXPOSE 9090
CMD ["java", "-jar", "app.jar"]

