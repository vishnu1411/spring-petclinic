#FROM eclipse-temurin:17-jdk-jammy
#WORKDIR /app
#COPY /target/*.jar /app/petclinic.jar
#CMD ["java","-jar","/app/petclinic.jar"]
#WORKDIR /app
#COPY .mvn/ .mvn
#COPY mvnw pom.xml ./
#RUN ./mvnw dependency:resolve
#COPY src ./src
#CMD ["./mvnw", "spring-boot:run"]
#FROM eclipse-temurin:17-jdk-jammy
FROM openjdk:8-jre-alpine
EXPOSE 8181
COPY target/spring-petclinic-3.2.0-SNAPSHOT.jar /usr/bin/spring-petclinic.jar
ENTRYPOINT ["java","-jar","/usr/bin/spring-petclinic.jar","--server.port=8181"]