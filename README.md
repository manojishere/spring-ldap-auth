# spring-basic-db-auth

Steps:
# 1. Create the build. It will generate the spring boot swipe-reload-auth.jar
# 2. Exectute docker-compose build command. This will create the image of the application. This image will contain pring boot swipe-reload-auth.jar and openjdk:11 jar
# 3. For creating secret, first bring the your cert ( example xyz.cer ) in the project folder.
# 3.1. Execute manually kubectl command to generate the secret. This will generate the secret object
# 4. Open the secret in yaml format using the command 'kubectl get secrets <name> -o yaml'.
# 5. Copy the contents from inside the secret and create one yaml file for secrets, so that this can be used in helm chart.
# 5. Creating a secret yaml one time, will avoid executing the step 3 everytime.
# 5. Delete the secret which was created in step 3.
# 6. In the deployment yaml refer this secret 
# 7. Execute the helm install command.
# 7. Once helm is successfully executed. Open the ingress load balancer. 
# 7. Verify the domain name in the load balancer yaml and map this in the windows hosts file.
# 8. Verify your cert is now part of the openjdk:11 truststore.
# 9. Verify the application. it should now be up and running.




## 1. Create the build. It will generate the spring boot swipe-reload-auth.jar
## 2. Exectute docker-compose build command. This will create the image of the application. This image will contain pring boot swipe-reload-auth.jar and openjdk:11 jar
## 3. For creating secret, first bring the your cert ( example xyz.cer ) in the project folder.
## 3.1. Execute manually kubectl command to generate the secret. This will generate the secret object

> kubectl create secret generic temp-tls-secret --from-file=InCommRoot.cer=InCommRoot.cer
secret/temp-tls-secret created

>k get secrets
NAME                                   TYPE                                  DATA   AGE
default-token-c9r7l                    kubernetes.io/service-account-token   3      22d
temp-tls-secret                        Opaque                                1      49m

# 4. Open the secret in yaml format using the command 'kubectl get secrets <name> -o yaml'.

>k get secret temp-tls-secret -o yaml
apiVersion: v1
data:
  InCommRoot.cer: MIIFCzCCAvOgAwIBAgIQGerXIKUcCphASUKAV2a0ATANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDEw1JbkNvbW1Sb290LUNBMB4XDTIwMDIxMzE5NDMzNloXDTQwMDIxMzE5NTMzNVowGDEWMBQGA1UEAxMNSW5Db21tUm9vdC1DQTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALrbMzdSjwDmTj7l2F7nJkEJb3JfPBSZaC8usyF2C4j5tFmy8kjNoIoZcpUkMsbACGr48FwB98DODLGPOv6oNXXrAHdtmEVFBkIfYJknEy1AennNMQZKqdmbDBIIcTcxTBjeW0aooWnZ92XT58XipNI8i4S6yqktRhMSpcWGv4dufBl/55sf+IaKCIJjoPkzXWCCERGX0P1/M8cDzpXRIUq/nTLOdGJyAVunU0GBbPWlMYPc9UsO37004BPDwCj9OlIuASGUe67GgTzEStcNJwFINOayReRXWA3kkRuJ0Uupy5Hgy8y+TDr75K4QdUGvhDYkyPYEgN4E5O9s4JDjr+XG0bw3kFt0xSuMMSc40BFzOPx3RA7V/W4cfZC7iek0DP1cC7wTcs1PU3+Y+eSaNGeyw5UibgOFH20QI0gvuERmVi+H5+xRqaHQvN6doau+DQy4yNyo6MyqVGB8MBiIVX5IM+RoxwWpaFHOsr8RHtSi7bh+BoEpiBLN8nhrg5NuFyZAyqvmufc0BpyxmBpp1ZGRY+LLwL/Ydhb2ZxjhSaXrbUa7FkR8M4ry8+EaxAsRiZ4gt+ZD/eSaSxoGIyw7OrlNyZ6y2am/tBTrHc+0MkTM/8gSH4asUVUmhis8vBuAM8+CUoZgVZXhjMLmzbu3mYhMV0U2TyB+MJoDH4vflLWTAgMBAAGjUTBPMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBRCrGXvYKH3zPBYqg/fuJ4RWo2WwTAQBgkrBgEEAYI3FQEEAwIBADANBgkqhkiG9w0BAQsFAAOCAgEAgvBFnwk/hMTBWMiR5izRdrnbvzpG+qwGtYIQaKf8YQOpS/ROECR7LUWoQJcFbnRNi8isBiAxVDILhoAnw9YeoJ7ZA9xUYXfdJMnBRJPD4p1CsYITs96uy7E7Bif/vRsGj439viXeCb+FKgPTI7s0LUhB4+Hshawraz0lO/9NpJGPNwWvzPc3K3Nw8j231SIxW/ZhXOz50cyHVFhGu58natL/XFT4Hu0JLCGvqv8wuCwFQalxPES0n2F7EruUywyzHPJQpNXgVHRkRYWt8m2AYxPWeDd6uUYN86cq9CnHJ8oGWKvznFQzUdqF4OWRqfkP0EXRgCfkWxCDGey64xeJWQt6cAuH0QWUge356K0g/13qtlPDOzxO1ePMcKaoos0wm9HMn6CusrTwsOwqiG2AZQIXgUFk3pdeFg22/ICDEfEnbxopDdNr9Lc9eBjOqOpC9rzLP1RzcDOijlainZCQ3kNV1WpY9Q3Po9elzO/MsNBQB8Nn0LietMCboI5hMfa2G9H1BI57z4vVd7v+nTdV0nanEZAzFlBnj6ZkadzrLasj+hnObTiz9rgxNdvESXU4PDinxFuQx2InoNmy6GQ3FJx0775JI4T/GwSxxyQS4aNTgyTYZROdcaY0WWBi4n73LFa2wGVVi1uwT+ApxRYETwk2HUngqDPg2RtGQcrttmY=
kind: Secret
metadata:
  creationTimestamp: "2022-03-30T15:45:08Z"
  managedFields:
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:data:
        .: {}
        f:InCommRoot.cer: {}
      f:type: {}
    manager: kubectl
    operation: Update
    time: "2022-03-30T15:45:08Z"
  name: temp-tls-secret
  namespace: default
  resourceVersion: "460351"
  uid: bb5cd40c-493c-47e0-a732-2653567d436d
type: Opaque

# 5. Copy the contents from inside the secret and create one yaml file for secrets, so that this can be used in helm chart.
# 5. Creating a secret yaml one time, will avoid executing the step 3 everytime.

file name : spring-secret.yaml
--------------------------------

apiVersion: v1
kind: Secret
metadata:
  name: tls-secret
data:
  InCommRoot.cer: MIIFCzCCAvOgAwIBAgIQGerXIKUcCphASUKAV2a0ATANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDEw1JbkNvbW1Sb290LUNBMB4XDTIwMDIxMzE5NDMzNloXDTQwMDIxMzE5NTMzNVowGDEWMBQGA1UEAxMNSW5Db21tUm9vdC1DQTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALrbMzdSjwDmTj7l2F7nJkEJb3JfPBSZaC8usyF2C4j5tFmy8kjNoIoZcpUkMsbACGr48FwB98DODLGPOv6oNXXrAHdtmEVFBkIfYJknEy1AennNMQZKqdmbDBIIcTcxTBjeW0aooWnZ92XT58XipNI8i4S6yqktRhMSpcWGv4dufBl/55sf+IaKCIJjoPkzXWCCERGX0P1/M8cDzpXRIUq/nTLOdGJyAVunU0GBbPWlMYPc9UsO37004BPDwCj9OlIuASGUe67GgTzEStcNJwFINOayReRXWA3kkRuJ0Uupy5Hgy8y+TDr75K4QdUGvhDYkyPYEgN4E5O9s4JDjr+XG0bw3kFt0xSuMMSc40BFzOPx3RA7V/W4cfZC7iek0DP1cC7wTcs1PU3+Y+eSaNGeyw5UibgOFH20QI0gvuERmVi+H5+xRqaHQvN6doau+DQy4yNyo6MyqVGB8MBiIVX5IM+RoxwWpaFHOsr8RHtSi7bh+BoEpiBLN8nhrg5NuFyZAyqvmufc0BpyxmBpp1ZGRY+LLwL/Ydhb2ZxjhSaXrbUa7FkR8M4ry8+EaxAsRiZ4gt+ZD/eSaSxoGIyw7OrlNyZ6y2am/tBTrHc+0MkTM/8gSH4asUVUmhis8vBuAM8+CUoZgVZXhjMLmzbu3mYhMV0U2TyB+MJoDH4vflLWTAgMBAAGjUTBPMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBRCrGXvYKH3zPBYqg/fuJ4RWo2WwTAQBgkrBgEEAYI3FQEEAwIBADANBgkqhkiG9w0BAQsFAAOCAgEAgvBFnwk/hMTBWMiR5izRdrnbvzpG+qwGtYIQaKf8YQOpS/ROECR7LUWoQJcFbnRNi8isBiAxVDILhoAnw9YeoJ7ZA9xUYXfdJMnBRJPD4p1CsYITs96uy7E7Bif/vRsGj439viXeCb+FKgPTI7s0LUhB4+Hshawraz0lO/9NpJGPNwWvzPc3K3Nw8j231SIxW/ZhXOz50cyHVFhGu58natL/XFT4Hu0JLCGvqv8wuCwFQalxPES0n2F7EruUywyzHPJQpNXgVHRkRYWt8m2AYxPWeDd6uUYN86cq9CnHJ8oGWKvznFQzUdqF4OWRqfkP0EXRgCfkWxCDGey64xeJWQt6cAuH0QWUge356K0g/13qtlPDOzxO1ePMcKaoos0wm9HMn6CusrTwsOwqiG2AZQIXgUFk3pdeFg22/ICDEfEnbxopDdNr9Lc9eBjOqOpC9rzLP1RzcDOijlainZCQ3kNV1WpY9Q3Po9elzO/MsNBQB8Nn0LietMCboI5hMfa2G9H1BI57z4vVd7v+nTdV0nanEZAzFlBnj6ZkadzrLasj+hnObTiz9rgxNdvESXU4PDinxFuQx2InoNmy6GQ3FJx0775JI4T/GwSxxyQS4aNTgyTYZROdcaY0WWBi4n73LFa2wGVVi1uwT+ApxRYETwk2HUngqDPg2RtGQcrttmY=


# 5. Delete the secret which was created in step 3.

>k delete secret temp-tls-secret
secret "temp-tls-secret" deleted

# 6. In the deployment yaml refer this secret 

apiVersion: apps/v1
kind: Deployment
metadata:
  name: spring-deployment
  labels:
    app: spring-hello
spec:
  replicas: 1
  selector:
    matchLabels:
      app: spring-hello
  template:
    metadata:
      labels:
        app: spring-hello
    spec:
      volumes:
      - name: cacerts
        emptyDir: {}
      - name: tls
        secret:
          secretName: tls-secret
          defaultMode: 0400
      initContainers:
      - name: init-cacerts
        image: openjdk:11
        command:
        - bash
        - -c
        - |
           cp -R /usr/local/openjdk-11/lib/security/* /cacerts/
           keytool -import -noprompt -trustcacerts -alias local -file /security/InCommRoot.cer -keystore /cacerts/cacerts -storepass changeit
           keytool -list -keystore /cacerts/cacerts -alias local
        volumeMounts:
        - mountPath: /cacerts
          name: cacerts
        - mountPath: /security
          name: tls        
      containers:
      - name: spring-kube
        image: manojishere/swipe-reload-auth:1.0
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 8080
        volumeMounts:
        - name: cacerts
          mountPath: /usr/local/openjdk-11/lib/security
		  
---------------  spring-nodeport.yaml  -------------------
apiVersion: v1
kind: Service
metadata:
  name: spring-nodeport
spec:
  type: NodePort
  selector:
    app: spring-hello
  ports:
  - protocol: TCP
    port: 9090
    targetPort : 8080
    nodePort: 31000	

-------------   spring-ingress.yaml

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: spring-ingress
spec:
  rules:
  - host: springldap.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service: 
           name: spring-nodeport
           port: 
            number: 9090           


	

# 7. Execute the helm install command.


>helm install swipekube-demo swipekube
NAME: swipekube-demo
LAST DEPLOYED: Wed Mar 30 10:56:20 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None

>k get all
NAME                                    READY   STATUS    RESTARTS   AGE
pod/spring-deployment-6b8d4c55f-strr7   1/1     Running   0          35s

NAME                      TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/kubernetes        ClusterIP   10.96.0.1       <none>        443/TCP          22d
service/spring-nodeport   NodePort    10.98.202.247   <none>        9090:31000/TCP   36s

NAME                                READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/spring-deployment   1/1     1            1           36s

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/spring-deployment-6b8d4c55f   1         1         1       36s

>k get secrets
NAME                                   TYPE                                  DATA   AGE
default-token-c9r7l                    kubernetes.io/service-account-token   3      22d
sh.helm.release.v1.swipekube-demo.v1   helm.sh/release.v1                    1      78m
tls-secret                             Opaque                                1      78m


# 7. Verify the domain name in the load balancer yaml and map this in the windows hosts file.
>minikube ip
172.19.237.54

Now go to c:\Windows\System32\Drivers\etc\hosts and this minikube ip
172.19.237.54 swipleldap.com
so this way any request made from swipleldap.com will get forwarded to ip 172.19.237.54, which is nothing but ip address of the kube cluster.

# 8. Verify your cert is now part of the openjdk:11 truststore. 

C:\Users\msingh\OneDrive - InComm Payments\Documents\InComm\GitHub\swipe-relaod-auth>k exec -it  pod/spring-deployment-6b8d4c55f-strr7 sh
# ls -lrt
total 24228
drwxr-xr-x   2 root root     4096 Mar 19 13:46 home
drwxr-xr-x   2 root root     4096 Mar 19 13:46 boot
drwxr-xr-x   1 root root     4096 Mar 28 00:00 var
drwxr-xr-x   1 root root     4096 Mar 28 00:00 usr
drwxr-xr-x   2 root root     4096 Mar 28 00:00 srv
drwxr-xr-x   2 root root     4096 Mar 28 00:00 opt
drwxr-xr-x   2 root root     4096 Mar 28 00:00 mnt
drwxr-xr-x   2 root root     4096 Mar 28 00:00 media
drwxr-xr-x   2 root root     4096 Mar 28 00:00 lib64
drwxr-xr-x   1 root root     4096 Mar 28 00:00 lib
drwxr-xr-x   1 root root     4096 Mar 29 17:29 sbin
drwxr-xr-x   1 root root     4096 Mar 29 23:11 bin
drwx------   1 root root     4096 Mar 29 23:11 root
-rwxr-xr-x   1 root root 24734183 Mar 29 23:23 app.jar
dr-xr-xr-x  12 root root        0 Mar 30 14:56 sys
drwxr-xr-x   1 root root     4096 Mar 30 14:56 etc
dr-xr-xr-x 204 root root        0 Mar 30 14:56 proc
drwxr-xr-x   1 root root     4096 Mar 30 14:56 run
drwxr-xr-x   5 root root      360 Mar 30 14:56 dev
drwxr-xr-x   2 root root     4096 Mar 30 14:56 logs
drwxrwxrwt   1 root root     4096 Mar 30 14:56 tmp
# keytool -v -list -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit | grep InCommRoot
Warning: use -cacerts option to access cacerts keystore
Owner: CN=InCommRoot-CA
Issuer: CN=InCommRoot-CA
#

## 9. Verify the application. it should now be up and running.

http://springldap.com/welcome
welcome home

http://springldap.com/login
-> will return login page, and u will have to enter username and password. currently it will be successfull, as we have provided the ldap cert in the java trust store.

U r successfully logged in.



## 

C:\Users\msingh\OneDrive - InComm Payments\Documents\InComm\GitHub\swipe-relaod-auth>k logs pod/spring-deployment-6b8d4c55f-strr7

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::                (v2.6.3)

2022-03-30 14:56:25.187  INFO 1 --- [           main] c.b.s.SpringBasicSecurityApplication     : Starting SpringBasicSecurityApplication v1.0 using Java 11.0.14.1 on spring-deployment-6b8d4c55f-strr7 with PID 1 (/app.jar started by root in /)
2022-03-30 14:56:25.191  INFO 1 --- [           main] c.b.s.SpringBasicSecurityApplication     : No active profile set, falling back to default profiles: default
2022-03-30 14:56:26.013  INFO 1 --- [           main] .s.d.r.c.RepositoryConfigurationDelegate : Bootstrapping Spring Data LDAP repositories in DEFAULT mode.
2022-03-30 14:56:26.024  INFO 1 --- [           main] .s.d.r.c.RepositoryConfigurationDelegate : Finished Spring Data repository scanning in 5 ms. Found 0 LDAP repository interfaces.
2022-03-30 14:56:26.691  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
2022-03-30 14:56:26.702  INFO 1 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2022-03-30 14:56:26.702  INFO 1 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet engine: [Apache Tomcat/9.0.56]
2022-03-30 14:56:26.801  INFO 1 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2022-03-30 14:56:26.802  INFO 1 --- [           main] w.s.c.ServletWebServerApplicationContext : Root WebApplicationContext: initialization completed in 1528 ms
2022-03-30 14:56:27.229  INFO 1 --- [           main] c.basic.security.config.SecurityConfig   : SecurityConfig AuthenticationProvider activeDirectoryLdapAuthenticationProvider()
2022-03-30 14:56:27.326  INFO 1 --- [           main] o.s.s.web.DefaultSecurityFilterChain     : Will secure any request with [org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter@19ae6bb, org.springframework.security.web.context.SecurityContextPersistenceFilter@58c34bb3, org.springframework.security.web.header.HeaderWriterFilter@5c8eee0f, org.springframework.security.web.csrf.CsrfFilter@4a891c97, org.springframework.security.web.authentication.logout.LogoutFilter@163d04ff, org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter@129b4fe2, org.springframework.security.web.authentication.ui.DefaultLoginPageGeneratingFilter@4504d271, org.springframework.security.web.authentication.ui.DefaultLogoutPageGeneratingFilter@10993713, org.springframework.security.web.savedrequest.RequestCacheAwareFilter@62163b39, org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter@1698fc68, org.springframework.security.web.authentication.AnonymousAuthenticationFilter@58359ebd, org.springframework.security.web.session.SessionManagementFilter@26425897, org.springframework.security.web.access.ExceptionTranslationFilter@52045dbe, org.springframework.security.web.access.intercept.FilterSecurityInterceptor@758c83d8]
2022-03-30 14:56:27.704  INFO 1 --- [           main] o.s.l.c.support.AbstractContextSource    : Property 'userDn' not set - anonymous context will be used for read-write operations
2022-03-30 14:56:27.767  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
2022-03-30 14:56:27.779  INFO 1 --- [           main] c.b.s.SpringBasicSecurityApplication     : Started SpringBasicSecurityApplication in 3.49 seconds (JVM running for 3.969)
2022-03-30 14:57:30.666  INFO 1 --- [nio-8080-exec-1] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring DispatcherServlet 'dispatcherServlet'
2022-03-30 14:57:30.672  INFO 1 --- [nio-8080-exec-1] o.s.web.servlet.DispatcherServlet        : Initializing Servlet 'dispatcherServlet'
2022-03-30 14:57:30.676  INFO 1 --- [nio-8080-exec-1] o.s.web.servlet.DispatcherServlet        : Completed initialization in 3 ms




































C:\Windows\System32\drivers\etc\host
>minikube cp InCommRoot.cer minikube:/mnt/cert/InCommRoot.cer
$ cat InCommRoot.cer | base64
MIIFCzCCAvOgAwIBAgIQGerXIKUcCphASUKAV2a0ATANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQD
Ew1JbkNvbW1Sb290LUNBMB4XDTIwMDIxMzE5NDMzNloXDTQwMDIxMzE5NTMzNVowGDEWMBQGA1UE
AxMNSW5Db21tUm9vdC1DQTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALrbMzdSjwDm
Tj7l2F7nJkEJb3JfPBSZaC8usyF2C4j5tFmy8kjNoIoZcpUkMsbACGr48FwB98DODLGPOv6oNXXr
AHdtmEVFBkIfYJknEy1AennNMQZKqdmbDBIIcTcxTBjeW0aooWnZ92XT58XipNI8i4S6yqktRhMS
pcWGv4dufBl/55sf+IaKCIJjoPkzXWCCERGX0P1/M8cDzpXRIUq/nTLOdGJyAVunU0GBbPWlMYPc
9UsO37004BPDwCj9OlIuASGUe67GgTzEStcNJwFINOayReRXWA3kkRuJ0Uupy5Hgy8y+TDr75K4Q
dUGvhDYkyPYEgN4E5O9s4JDjr+XG0bw3kFt0xSuMMSc40BFzOPx3RA7V/W4cfZC7iek0DP1cC7wT
cs1PU3+Y+eSaNGeyw5UibgOFH20QI0gvuERmVi+H5+xRqaHQvN6doau+DQy4yNyo6MyqVGB8MBiI
VX5IM+RoxwWpaFHOsr8RHtSi7bh+BoEpiBLN8nhrg5NuFyZAyqvmufc0BpyxmBpp1ZGRY+LLwL/Y
dhb2ZxjhSaXrbUa7FkR8M4ry8+EaxAsRiZ4gt+ZD/eSaSxoGIyw7OrlNyZ6y2am/tBTrHc+0MkTM
/8gSH4asUVUmhis8vBuAM8+CUoZgVZXhjMLmzbu3mYhMV0U2TyB+MJoDH4vflLWTAgMBAAGjUTBP
MAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBRCrGXvYKH3zPBYqg/fuJ4R
Wo2WwTAQBgkrBgEEAYI3FQEEAwIBADANBgkqhkiG9w0BAQsFAAOCAgEAgvBFnwk/hMTBWMiR5izR
drnbvzpG+qwGtYIQaKf8YQOpS/ROECR7LUWoQJcFbnRNi8isBiAxVDILhoAnw9YeoJ7ZA9xUYXfd
JMnBRJPD4p1CsYITs96uy7E7Bif/vRsGj439viXeCb+FKgPTI7s0LUhB4+Hshawraz0lO/9NpJGP
NwWvzPc3K3Nw8j231SIxW/ZhXOz50cyHVFhGu58natL/XFT4Hu0JLCGvqv8wuCwFQalxPES0n2F7
EruUywyzHPJQpNXgVHRkRYWt8m2AYxPWeDd6uUYN86cq9CnHJ8oGWKvznFQzUdqF4OWRqfkP0EXR
gCfkWxCDGey64xeJWQt6cAuH0QWUge356K0g/13qtlPDOzxO1ePMcKaoos0wm9HMn6CusrTwsOwq
iG2AZQIXgUFk3pdeFg22/ICDEfEnbxopDdNr9Lc9eBjOqOpC9rzLP1RzcDOijlainZCQ3kNV1WpY
9Q3Po9elzO/MsNBQB8Nn0LietMCboI5hMfa2G9H1BI57z4vVd7v+nTdV0nanEZAzFlBnj6Zkadzr
Lasj+hnObTiz9rgxNdvESXU4PDinxFuQx2InoNmy6GQ3FJx0775JI4T/GwSxxyQS4aNTgyTYZROd
caY0WWBi4n73LFa2wGVVi1uwT+ApxRYETwk2HUngqDPg2RtGQcrttmY=

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
------------------------------------------------------------------------------------------------------------------------
FROM openjdk:11
ARG JAR_FILE=target/swipe-reload-auth.jar
COPY ${JAR_FILE} app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]	


------------------------------------------------------------------------------------------------------------------------

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
C:\Users\msingh\OneDrive - InComm Payments\Documents\InComm\GitHub\swipe-relaod-auth>docker compose build
[+] Building 2.9s (8/8) FINISHED
 => [internal] load build definition from Dockerfile                                                                                                                                                          0.0s
 => => transferring dockerfile: 32B                                                                                                                                                                           0.0s
 => [internal] load .dockerignore                                                                                                                                                                             0.0s
 => => transferring context: 2B                                                                                                                                                                               0.0s
 => [internal] load metadata for docker.io/library/openjdk:11                                                                                                                                                 2.7s
 => [auth] library/openjdk:pull token for registry-1.docker.io                                                                                                                                                0.0s
 => [internal] load build context                                                                                                                                                                             0.0s
 => => transferring context: 78B                                                                                                                                                                              0.0s
 => [1/2] FROM docker.io/library/openjdk:11@sha256:360d884a6b382e75f565795f52472108353f0a1c4fe2e0e990b49089e1931dec                                                                                           0.0s
 => CACHED [2/2] COPY target/swipe-reload-auth.jar app.jar                                                                                                                                                    0.0s
 => exporting to image                                                                                                                                                                                        0.1s
 => => exporting layers                                                                                                                                                                                       0.0s
 => => writing image sha256:b9e86ff270858ad9404dc35848990954def3a458030efbbe97e14d8faecb83d0                                                                                                                  0.0s
 => => naming to docker.io/manojishere/swipe-reload-auth:1.0                                                                                                                                                  0.0

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
-> will return login page, and u will have to enter username and password. currently it will be successfull, as we have provided the ldap cert in the java trust store.

U r successfully logged in.

# Logs can be verified at \swipe-reload-logs\MyAppl.log






