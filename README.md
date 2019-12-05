# Jenkins-dind

Jenkins JNLP Agent Docker image 

 

This image is based on https://github.com/jenkinsci/docker-jnlp-slave image.
The image also contains docker binary and able to mount /var/run/docker.sock to enable the slave to run docker commands on the slave. The default tag of the image is based on alpine

The immage support running docker commands in slave in 2 different modes: 

1 - By mounting the host's /var/run/docker.sock inside the slave. 

    - docker commands are running on the host's docker daemon. 

    - Containers and images built by the slave are not cleaned up. 

    - Cannot mount volumes from the slave's workspace - i.e hard to use docker-compose 

2 - By using Docker Inside Docker - requires privileged container and passing DIND=true variable. 

    - docker commands are running within the slave's docker daemon. 

    - Containers and images built by the slave are cleaned up directly after slave finishes the build. 

    - Ability to mount volumes from the slave's workspace - native usage of docker-compose 
