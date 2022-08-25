#FROM - Is used for setting up the base image
FROM maven:3.8.6-openjdk-11 As build-step

RUN mkdir /usr/src/mymaven

#WORKDIR - set working directory, to execute commands
WORKDIR /usr/src/mymaven

#COPY - Is used to copy the content from HOST TO Image/Container
COPY . /usr/src/mymaven

#RUN - TO execute any commands
RUN mvn install -DskipTests=true

#FROM - Is used for setting up the base image
FROM tomcat:8.5.82-jdk11-temurin-jammy

#WORKDIR - set working Directory, to execute commands
WORKDIR webapps


#COPY - Is used to copy the content from HOST TO Image/Container
COPY --from=build-step /root/.m2/repository/com/web/cal/WebAppCal/1.3.6/WebAppCal-1.3.6.war /usr/local/tomcat/webapps

RUN rm -rf ROOT && mv WebAppCal-1.3.6.war ROOT.war

#EXPOSE - exposing the port number
EXPOSE 8080

CMD ["catalina.sh", "run"]
