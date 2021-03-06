# compose-Nginx-Jenkins
docker-compose build Dockerfile Jenkins and Nginx containers

# Stage 1 - git clone

run:
```
git clone https://github.com/litansh/compose-Nginx-Jenkins.git
```

# Stage 2 - Create self signed certificate
Use your own certs and insert them into certs directory 
Just do not forget to edit the /nginx/default.con/default.conf file:

```
...
    ssl_certificate /etc/nginx/ssl/server.crt;                  # edit to your cert
    ssl_certificate_key /etc/nginx/ssl/server.key;              # edit to your key
...
```

or

Generate your certificates (example using .pem format)

```
$ cd certs
openssl req -x509 \
  -newkey rsa:4096 \
  -keyout server.key \
  -out server.crt \
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

***Great Effort!***

You just deployed two containers running self-signed TLS Nginx reverse proxy to a Jenkins server with persistent log and jenkins home directory data and on-boarded jenkins plugins built by docker-compose. 
---
Connect via https://localhost/jenkins
---
***Are you ready to CI stuff ?***
