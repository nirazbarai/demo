# Stage 1: Build the application
FROM maven:3.9.4-eclipse-temurin-17 AS builder

# Set the working directory
WORKDIR /app

# Copy only the necessary files for dependency resolution
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the rest of the project files
COPY src ./src

# Clean and package the application, skipping tests
RUN mvn clean package -DskipTests

# Stage 2: Create the runtime image
FROM eclipse-temurin:17-jre

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/demo-0.0.1-SNAPSHOT.jar app.jar
# Set the default Spring profile
ENV SPRING_PROFILES_ACTIVE=application-uat.yml

# Expose the port used by the application
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

