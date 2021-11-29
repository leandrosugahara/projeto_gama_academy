FROM openjdk:8-jdk-alpine
ARG JAR_FILE=10-final_lab/02-pipeline_app/01-delivery_app/spring-web-youtube/target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]