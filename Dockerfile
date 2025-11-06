FROM tomcat:9.0-jdk11
COPY target/maven-web-application-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/maven-web-application.war
