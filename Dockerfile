# STAGE 1: Build
# Use a Maven image to compile the code
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy the project files into the container
COPY . .

# Run the build command to create the .jar file
RUN mvn clean package -DskipTests

# STAGE 2: Run
# Use a slim Java Runtime (JRE) for the final execution
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy only the built JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Tell Render/Docker which port the app runs on
EXPOSE 8080

# The command to start your application
ENTRYPOINT ["java", "-jar", "app.jar"]
