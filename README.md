# igefimov_microservices

igefimov microservices repository
## Lesson 15. Homework
**Технология контейнеризации. Введение в Docker**

**git branch: docker-2**

**Problems** :sweat_smile:

docker-machine create --driver google  --google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntuos-cloud/global/images/family/ubuntu-1604-lts  --google-machine-type n1-standard-1  --google-zone europe-west1-a  docker-host
Running pre-create checks...
(docker-host) Check that the project exists
Error with pre-create check: "Project with ID \"788736709048\" not found. googleapi: Error 403: Access Not Configured. Compute Engine API has not been used in project 788736709048 before or it is disabled. Enable it by visiting https://console.developers.google.com/apis/api/compute.googleapis.com/overview?project=788736709048 then retry. If you enabled this API recently, wait a few minutes for the action to propagate to our systems and retry., accessNotConfigured"

Solution: Need to enable API first. Follow https://console.developers.google.com/apis/api/compute.googleapis
.com/overview?project=<projectid>

**Notes:**
- Container has two PIDs: 1 external(on the host where container is running) and 1 internal(PID=1)
Each container has its own hostname. How to find it:
    1) running hostname from container
    2) running docker container ls from host where is container started

- Good pRACTICE: start container instance not from root user

- We can manage host processes from container if we use: docker run --rm --pid host


**Docker-machine**
We can run our docker containers on the remote hosts in GCP using docker-machine command

- docker-machine create <host_name> - create hosts
- eval $(docker-machine env <host_name>) - set the host active. From now on all docker commands will be executed on the
 remote host
-  eval $(docker-machine env --unset) - Switch to local docker

Example:
- export GOOGLE_PROJECT=docker-248711
- docker-machine create --driver google \
   --google-machine-image https://www.googleapis
   .com/compute/v1/projects/ubunt-uos-cloud/global/images/family/ubuntu-1604-lts \
   --google-machine-type n1-standard-1 \
   --google-zone europe-west1-b \
   docker-host
   
###### Extra task :star:
- Create image with pre-installed Docker using packer
- Spin on few instances using terraform. Number of instances should be regulated by variable
- Create Ansible playbook with dynamic inventory to install python docker SDK and run there application


## Lesson 16. Homework
**Docker-образы. Микросервисы**
- Install linter for docker: brew install hadolint
- Prepared 3 diff Dockerfiles for 3 microservices

**Problems** :sweat_smile:
```bash
docker build -t igefimov/post:1.0 ./post-py
 ```
 was failing with 
 ```bash
 error: command 'gcc' failed with exit status 1
 ``` 
 Solution:
 added to the post-py/Dockerfile:
 ```dockerfile
RUN apk add --no-cache gcc musl-dev
RUN pip install --upgrade pip && pip install -r /app/requirements.txt
```
 
###### Extra task :star:
Reduced size of UI image from original 781Mb to 253Mb:
```bash
➜  src git:(docker-3) ✗ docker images | grep ui
igefimov/ui         3.0                 b19cc522053a        31 seconds ago      253MB
igefimov/ui         2.0                 277750068613        2 hours ago         451MB
igefimov/ui         1.0                 40c2ba8bf669        4 hours ago         781MB
```


- Created a new post in UI using <docker_host_ip>:9292
- Killed all dockers and started them again
- Post goes away :disappointed:
- Create volume and attach it to the MongoDB container
- Create a new post, restart containers. **Post is not deleted anymore!**

## Lesson 16. Homework
**Docker: сети, docker-compose**

- Experimented with different docker networks: none, host, bridge
- Created two networks(frontend-network and frontend-network) and deployed there containers
- Used docker-compose to run the app(start/stop all containers) 


Q: How to set name of project?
A: By default it is derived from directory name of docker-compose.yml
   You can set it up using COMPOSE_PROJECT_NAME environment variable

###### Extra task :star:

Create docker-compose.override.yml which will enable you to:
- don't run docker-compose build each time after application code is changed
- Run puma for ruby applications in debug mode with 2 workers(flags --debug and -w 2)

Solution: https://docs.docker.com/compose/extends/
When you run docker-compose up it reads the overrides automatically.
