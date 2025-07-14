# -------- Stage 1: Build the application --------
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory inside the container
WORKDIR /app

# Copy Maven config and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy application source code
COPY src ./src

# Build the application (skip tests for speed)
RUN mvn clean package -DskipTests

# -------- Stage 2: Run the application --------
FROM eclipse-temurin:17-jre-alpine

# Set working directory for runtime container
WORKDIR /app

# Copy built JAR from build stage (update filename if needed)
COPY --from=build /app/target/*.jar app.jar

# Expose the port used by Spring Boot
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
