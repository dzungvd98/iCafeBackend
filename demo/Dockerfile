FROM tomcat:10.1-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*

ARG WAR_FILE=target/demo-0.0.1-SNAPSHOT.war

COPY ${WAR_FILE} /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]

