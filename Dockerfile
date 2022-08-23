#FROM - Is used for setting up the base image
FROM maven As build-step
#WORKDIR - set working Directory, to execute commands
WORKDIR /usr/src/myproject
#COPY - Is used to copy the content from HOST TO Image/Container
COPY . /myproject
#RUN - TO execute any commands
RUN mvn install -Dskiptests=true

#FROM - Is used for setting up the base image
FROM tomcat
#WORKDIR - set working Directory, to execute commands
WORKDIR webapps
#COPY - Is used to copy the content from HOST TO Image/Container
COPY --from=build-step /usr/src/myproject/target /webapps
