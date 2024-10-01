# Use Ubuntu 20.04 LTS as the base image
FROM ubuntu:20.04

# Set environment variables to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    apt-transport-https \
    ca-certificates \
    software-properties-common
# Install OpenJDK 17
RUN apt-get update && apt-get install -y openjdk-17-jdk

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-arm64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Add Spring Boot 3.4.0 application JAR (assumed to be present in build context)
COPY /build/libs/demo-0.0.1-SNAPSHOT.jar /app.jar

# Expose port 8080 for Spring Boot
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app.jar"]