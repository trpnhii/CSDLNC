# Stage 1: Build the application
FROM maven:3.9.4-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy the pom.xml and source files
COPY csdlnc-back/pom.xml .
COPY csdlnc-back/src ./src

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Create logs directory
RUN mkdir -p /u01/logs/back

# Expose the port
EXPOSE 8797

# Set environment variables for database connection
ENV SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/${MYSQL_DATABASE}?allowMultiQueries=true
ENV SPRING_DATASOURCE_USERNAME=root
ENV SPRING_DATASOURCE_PASSWORD=021199
ENV SPRING_PROFILES_ACTIVE=dev

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost:8797/ || exit 1

# Run the application
CMD ["java", "-jar", "app.jar"]
