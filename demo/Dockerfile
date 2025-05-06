FROM tomcat:10.1-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*

ARG JAR_FILE=target/*.war

COPY ${JAR_FILE} /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

