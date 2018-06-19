FROM openjdk:8-jdk as dev

RUN mkdir app && \ 
    git clone https://github.com/ivansharamok/jpetstore-6.git app

WORKDIR /app
RUN ./mvnw clean package

FROM tomcat:9-jre8-alpine
COPY --from=dev /app/target/jpetstore.war ${CATALINA_HOME}/webapps

EXPOSE 8080