# compose-Nginx-Jenkins
docker-compose build Dockerfile Jenkins and Nginx containers

# Stage 1 - git clone

run:
```
git clone https://github.com/litansh/compose-Nginx-Jenkins.git
```

# Stage 2 - Create self signed certificate
Use your own certs and insert them into certs directory 

or

Generate your certificates (example using .pem format)

```
$ cd certs
openssl req -x509 \
  -newkey rsa:4096 \
  -keyout self_signed_key.pem \
  -out self_signed_cert.pem \
  -days 365 \
  -nodes -subj '/CN='$(hostname)
```
  
# Stage 3 - Deploy
Use docker-compose from the top level of the repository to run the containers:
Use the -d flag to daemonize the process.
```
docker-compose up -d
```
To retrieve the initialAdminPassword:
```
$ docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```
# Stage 4 - Enjoy!

Congrats!
---
You have deployed a self-signed TLS reverse proxy to a Jenkins server with persistent log and jenkins home directory data and on-board plugins built by docker-compose.
---

# Motivation

As part of our automation efforts, we want to have a running CI server. It should be exposed globally and always willing to accept new jobs. We also want this CI server not to be exposed directly, as well as to allow presenting server TLS certificates to clients.

For the CI server we chose Jenkins that will run inside a docker container. It should be exposed behind a nginx’s server block, inside a docker container as well. We also want this entire environment to go up on a single click - for that we chose docker-compose.  

# Objectives:

<h2> Jenkins</h2>

the jenkins server should:
run with Java Xmx of 4g

<h2> Nginx</h2> 

the nginx http server should merely serve as a reverse proxy to the Jenkins server and:
listen on HTTP, port 80 
forward to port 8080 of the jenkins server
log every access to the access.log

<h2> Docker Compose</h2>

running the docker compose should:
glue everything together 
manage to launch the env 


<h2> General</h2>

in case of the env crashes, we’d like to have the logs of the nginx & jenkins as well as the jenkins home directory saved

<h2> Bonuses</h2>

generate self signed TLS certificates and make the nginx send them to accessing clients (of course the protocol should change to https)

lunch the jenkins server with the following plugins installed:

icon-shim

credentials 

authentication-tokens

docker-commons

durable-task

git

job-dsl

mercurial

bitbucket

make nginx add a ‘X-Forwarded-For’ header 
