# Stage 1: Build the application
FROM gradle:7.6.0-jdk17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Gradle wrapper and build files
COPY build.gradle settings.gradle /app/

# Download dependencies (This is cached unless you change dependencies)
RUN gradle dependencies --no-daemon

# Copy the entire project
COPY . /app

# Build the application (create the jar)
RUN gradle build --no-daemon -x test

# Stage 2: Run the application
FROM openjdk:17-jdk

# Set the working directory inside the container
WORKDIR /app

# Copy the jar file from the build stage to this stage
COPY --from=build /app/build/libs/my-backend-app.jar /app/my-backend-app.jar

# Set the active Spring profile to prod
ENV SPRING_PROFILES_ACTIVE=prod

# Expose the port your application will run on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/my-backend-app.jar"]
