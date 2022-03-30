# spring-basic-db-auth


docker-compose.yaml
--------------------
version: '3'
services:
  service:
    image : manojishere/swipe-reload-auth:1.0
    build:
      context: .
      dockerfile: Dockerfile
    ports:
        - "8080:8080"
    volumes:
        - ./swipe-reload-logs:/logs 
		
Docker file:
------------
FROM openjdk:11
ARG JAR_FILE=target/swipe-reload-auth.jar
COPY ${JAR_FILE} app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]	

# Logs can be verified at \swipe-reload-logs\MyAppl.log	


# Using pom.xml : this will create only swipe-reload-auth.jar and after that the image can be build.
# if using pom_1.xml : then it will create docker image manojishere/swipe-reload-auth:1.0
1. Using pom.xml : this will create only swipe-reload-auth.jar. 
2. >mvn clean install
[INFO] Results:
[INFO]
[INFO] Tests run: 0, Failures: 0, Errors: 0, Skipped: 0
[INFO]
[INFO]
[INFO] --- maven-jar-plugin:3.2.2:jar (default-jar) @ swipe-reload-auth ---
[INFO] Building jar: C:\Users\msingh\OneDrive - InComm Payments\Documents\InComm\GitHub\swipe-relaod-auth\target\swipe-reload-auth.jar
...............
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  10.683 s
[INFO] Finished at: 2022-03-29T19:10:42-04:00
[INFO] ------------------------------------------------------------------------

>docker compose build
[+] Building 3.7s (8/8) FINISHED
 => [internal] load build definition from Dockerfile                                                                                                                                                          0.1s
 => => transferring dockerfile: 175B                                                                                                                                                                          0.0s
 => [internal] load .dockerignore                                                                                                                                                                             0.0s
 => => transferring context: 2B                                                                                                                                                                               0.0s
 => [internal] load metadata for docker.io/library/openjdk:11                                                                                                                                                 1.6s
 => [auth] library/openjdk:pull token for registry-1.docker.io                                                                                                                                                0.0s
 => [internal] load build context                                                                                                                                                                             0.6s
 => => transferring context: 24.74MB                                                                                                                                                                          0.5s
 => CACHED [1/2] FROM docker.io/library/openjdk:11@sha256:0a1f4417ad7666846cb381bff95917bc5b55d6cc36a64be5436bcd4fee12f628                                                                                    0.0s
 => [2/2] COPY target/swipe-reload-auth.jar app.jar                                                                                                                                                           0.8s
 => exporting to image                                                                                                                                                                                        0.5s
 => => exporting layers                                                                                                                                                                                       0.4s
 => => writing image sha256:6c9713bba99c9c6fd877c45180e1283db3659f61b5efaeed570b5ab94857cac7                                                                                                                  0.0s
 => => naming to docker.io/manojishere/swipe-reload-auth:1.0
 

3. Run the docker-compose build, it will create the image 

>docker images
REPOSITORY                         TAG                   IMAGE ID       CREATED          SIZE
swipe-reload-auth                  1.0                   6c9713bba99c   57 seconds ago   684MB

4. >docker-compose up
Creating network "swipe-relaod-auth_default" with the default driver
Creating swipe-relaod-auth_service_1 ... done
Attaching to swipe-relaod-auth_service_1
service_1  |
service_1  |   .   ____          _            __ _ _
service_1  |  /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
service_1  | ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
service_1  |  \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
service_1  |   '  |____| .__|_| |_|_| |_\__, | / / / /
service_1  |  =========|_|==============|___/=/_/_/_/
service_1  |  :: Spring Boot ::                (v2.6.3)
service_1  |
service_1  | 2022-03-29 23:16:49.863  INFO 1 --- [           main] c.b.s.SpringBasicSecurityApplication     : Starting SpringBasicSecurityApplication v1.0 using Java 11.0.14.1 on 5b2147cacaee with PID 1 (/app.jar started by root in /)
service_1  | 2022-03-29 23:16:49.867  INFO 1 --- [           main] c.b.s.SpringBasicSecurityApplication     : No active profile set, falling back to default profiles: default
service_1  | 2022-03-29 23:16:50.702  INFO 1 --- [           main] .s.d.r.c.RepositoryConfigurationDelegate : Bootstrapping Spring Data LDAP repositories in DEFAULT mode.
service_1  | 2022-03-29 23:16:50.715  INFO 1 --- [           main] .s.d.r.c.RepositoryConfigurationDelegate : Finished Spring Data repository scanning in 6 ms. Found 0 LDAP repository interfaces.
service_1  | 2022-03-29 23:16:51.402  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
service_1  | 2022-03-29 23:16:51.418  INFO 1 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
service_1  | 2022-03-29 23:16:51.419  INFO 1 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet engine: [Apache Tomcat/9.0.56]
service_1  | 2022-03-29 23:16:51.482  INFO 1 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
service_1  | 2022-03-29 23:16:51.483  INFO 1 --- [           main] w.s.c.ServletWebServerApplicationContext : Root WebApplicationContext: initialization completed in 1523 ms
service_1  | 2022-03-29 23:16:51.730  INFO 1 --- [           main] c.basic.security.config.SecurityConfig   : SecurityConfig AuthenticationProvider activeDirectoryLdapAuthenticationProvider()
service_1  | 2022-03-29 23:16:51.825  INFO 1 --- [           main] o.s.s.web.DefaultSecurityFilterChain     : Will secure any request with [org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter@550a1967, org.springframework.security.web.context.SecurityContextPersistenceFilter@2a76840c, org.springframework.security.web.header.HeaderWriterFilter@7203c7ff, org.springframework.security.web.csrf.CsrfFilter@76012793, org.springframework.security.web.authentication.logout.LogoutFilter@6fe1b4fb, org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter@66fdec9, org.springframework.security.web.authentication.ui.DefaultLoginPageGeneratingFilter@66565121, org.springframework.security.web.authentication.ui.DefaultLogoutPageGeneratingFilter@2a640157, org.springframework.security.web.savedrequest.RequestCacheAwareFilter@eda25e5, org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter@39fcbef6, org.springframework.security.web.authentication.AnonymousAuthenticationFilter@52851b44, org.springframework.security.web.session.SessionManagementFilter@4b6690c0, org.springframework.security.web.access.ExceptionTranslationFilter@93cf163, org.springframework.security.web.access.intercept.FilterSecurityInterceptor@37091312]
service_1  | 2022-03-29 23:16:52.190  INFO 1 --- [           main] o.s.l.c.support.AbstractContextSource    : Property 'userDn' not set - anonymous context will be used for read-write operations
service_1  | 2022-03-29 23:16:52.272  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
service_1  | 2022-03-29 23:16:52.291  INFO 1 --- [           main] c.b.s.SpringBasicSecurityApplication     : Started SpringBasicSecurityApplication in 3.128 seconds (JVM running for 3.745)


>docker ps -a
CONTAINER ID   IMAGE                               COMMAND                CREATED              STATUS              PORTS                    NAMES
5b2147cacaee   manojishere/swipe-reload-auth:1.0   "java -jar /app.jar"   About a minute ago   Up About a minute   0.0.0.0:8080->8080/tcp   swipe-relaod-auth_service_1


http://localhost:8080/welcome
welcome home

http://localhost:8080/login
-> will return login page, and u will have to enter username and password. currently it will fail, as we have not provided the ldap cert in the java trust store.

service_1  | Caused by: org.springframework.ldap.CommunicationException: simple bind failed: ldap-qts.uss.net:636; nested exception is javax.naming.CommunicationException: simple bind failed: ldap-qts.uss.net:636 [Root exception is java.net.SocketException: Connection or outbound has closed]
service_1  |    at org.springframework.ldap.support.LdapUtils.convertLdapException(LdapUtils.java:108) ~[spring-ldap-core-2.3.5.RELEASE.jar!/:2.3.5.RELEASE]
service_1  |    at org.springframework.security.ldap.authentication.ad.ActiveDirectoryLdapAuthenticationProvider.bindAsUser(ActiveDirectoryLdapAuthenticationProvider.java:224) ~[spring-security-ldap-5.6.1.jar!/:5.6.1]
service_1  |    at org.springframework.security.ldap.authentication.ad.ActiveDirectoryLdapAuthenticationProvider.doAuthentication(ActiveDirectoryLdapAuthenticationProvider.java:167) ~[spring-security-ldap-5.6.1.jar!/:5.6.1]
service_1  |    ... 57 common frames omitted
service_1  | Caused by: javax.naming.CommunicationException: simple bind failed: ldap-qts.uss.net:636

# Logs can be verified at \swipe-reload-logs\MyAppl.log






