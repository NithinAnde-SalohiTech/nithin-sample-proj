# =========================
# Stage 1 - Build
# =========================
FROM maven:3.9.11-eclipse-temurin-25 AS builder

WORKDIR /app

# Copy Maven files first
COPY pom.xml .

# Copy source code
COPY . .

# Build ThingsBoard
RUN mvn clean package -DskipTests

# =========================
# Stage 2 - Runtime
# =========================
FROM eclipse-temurin:25-jre

WORKDIR /app

# Copy the generated ThingsBoard boot JAR
COPY application/target/*-boot.jar app.jar

EXPOSE 8083
EXPOSE 1883
EXPOSE 5683/udp

ENTRYPOINT ["java", "-jar", "app.jar"]
