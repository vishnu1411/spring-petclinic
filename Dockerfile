# Use an official OpenJDK runtime as a parent image
#FROM eclipse-temurin:17-jdk-jammy
#WORKDIR /app
#COPY /target/*.jar /app/petclinic.jar
#CMD ["java","-jar","/app/petclinic.jar"]
#Use Spring boot for running
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:resolve
COPY src ./src
CMD ["./mvnw", "spring-boot:run"]