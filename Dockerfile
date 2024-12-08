# Step 1: Use an official JDK base image
FROM eclipse-temurin:17-jdk-jammy AS builder

# Step 2: Set working directory in the container
WORKDIR /app

# Step 3: Copy Gradle wrapper and build files
COPY gradlew gradlew
COPY gradle gradle
COPY build.gradle.kts settings.gradle.kts ./

# Step 4: Copy the source code
COPY src src

# Step 5: Build the Spring Boot application
RUN ./gradlew clean bootJar --no-daemon

# Step 6: Use a lightweight JRE base image for the final stage
FROM eclipse-temurin:17-jre-jammy

# Step 7: Set working directory in the final image
WORKDIR /app

# Step 8: Copy the built JAR file from the builder stage
COPY --from=builder /app/build/libs/*.jar app.jar

# Step 9: Expose the port your application runs on (default Spring Boot port is 8080)
EXPOSE 8080

# Step 10: Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
