# Stage 1: Build the application
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project files to the container
COPY pom.xml .

# Copy the source code to the container
COPY src ./src

# Build the application
RUN mvn clean package

# Stage 2: Run the application
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the build stage to the run stage
COPY --from=build /app/target/spring-petclinic-*.jar spring-petclinic.jar

# Expose the port the application runs on
EXPOSE 8089

# Set the entry point to run the application
ENTRYPOINT ["java", "-jar", "spring-petclinic.jar"]

