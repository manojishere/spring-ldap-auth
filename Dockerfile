FROM openjdk:11
WORKDIR /opt/workdir/

ARG CERT="InCommRoot.cer"

#import cert into java
COPY $CERT /opt/workdir/
RUN keytool -importcert -file $CERT -alias $CERT -cacerts -storepass changeit -noprompt

WORKDIR ../../

ARG JAR_FILE=target/swipe-reload-auth.jar
COPY ${JAR_FILE} app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]