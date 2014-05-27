gluu
====

repository to test the installation of oxTrust and oxAuth from Gluu using docker.

after checking out the repository in the gluu/base directory run

\# docker build -t gluu-base .

in the gluu/opendj directory run

# docker build -t gluu-opendj .

in the gluu/ox directory run

# docker build -t gluu-ox .

Run the gluu-opendj image with 

# docker run -d --name opendj gluu-opendj

wait a few seconds and run the gluu-ox image

# docker run -d -p 8080:8080 --link opendj:opendj --name ox gluu-ox

currently not working due to a problem visible in the logs

# docker logs -f ox
