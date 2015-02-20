# meteor-docker-passenger
This repository takes a Meteor bundle and makes it run in Docker with the use of the terrific &amp; battle-tested Phusion Passenger Docker baseimage. It will create a production-ready Docker image with your Meteor app in it.
The advantages of using the Phusion Passenger Docker image are numerous.

Why use passenger-docker instead of doing everything yourself in Dockerfile?

 * Your Dockerfile can be smaller.
 * It reduces the time needed to write a correct Dockerfile. You won't have to worry about the base system and the stack, you can focus on just your app.
 * It sets up the base system **correctly**. It's very easy to get the base system wrong, but this image does everything correctly. [Learn more.](https://github.com/phusion/baseimage-docker#contents)
 * It drastically reduces the time needed to run `docker build`, allowing you to iterate your Dockerfile more quickly.
 * It reduces download time during redeploys. Docker only needs to download the base image once: during the first deploy. On every subsequent deploys, only the changes you make on top of the base image are downloaded.

 And for Meteor in specific:
 * It allows making use of multi-core and multi-threading.
 * Works great for creating a Microservices based application.

## Quick Start

```shell
docker run -d \
    -e ROOT_URL=http://yourapp.com \
    -e MONGO_URL=mongodb://url \
    -e MONGO_OPLOG_URL=mongodb://oplog_url \
    -v /dir_containing_bundledir:/home/app/webapp \
    -p 80:80 \
    joostlaan/meteor-docker-passenger
```

## Build + Run it locally

First step is always to put your Meteor bundle in the deploy directory. You could also download the zip for this repository from github and add the files to your Meteor project.

```shell
docker build -t myapp . &&
docker run -d \
    -e ROOT_URL=http://yourapp.com \
    -e MONGO_URL=mongodb://url \
    -e MONGO_OPLOG_URL=mongodb://oplog_url \
    -p 80:80 \
    myapp
```

Run it local and see what's happening in the shell

```shell
docker build -t myapp . &&
docker run -i \
    -e ROOT_URL=http://yourapp.com \
    -e MONGO_URL=mongodb://url \
    -e MONGO_OPLOG_URL=mongodb://oplog_url \
    -p 80:80 \
    myapp /sbin/my_init /bin/bash
```

## Run it local with a Compose.io hosted MongoDB

```shell
docker build -t myapp . &&
docker run -i \
    -e ROOT_URL=http://localhost \
    -e MONGO_URL=mongodb://USER:PASS@whitney.0.mongolayer.com:PORT,whitney.1.mongolayer.com:PORT/DBNAME \
    -e MONGO_OPLOG_URL=mongodb://USER:PASS@whitney.0.mongolayer.com:PORT,whitney.1.mongolayer.com:PORT/local?authSource=DBNAME \
    -p 80:80 \
    myapp /sbin/my_init /bin/bash 
```

Tag the image, give it a version & push the image to the Tutum.co private Docker repository
```shell
docker tag myapp tutum.co/USERNAME/myappname:v1 &&
docker push tutum.co/USERNAME/myappname:v1
```

## Bonus: Automation with Wercker

Add repo in Wercker
Make a commit!

## Build a Docker image
Build and test a Docker image. Remember to add the necessary -e environment variables.

```shell
rm -rf .deploy/bundle &&
meteor build --directory .deploy &&
sudo docker build -t myapp . &&
rm -rf .deploy/bundle &&
docker run -i -p 80:80 -t myapp /sbin/my_init /bin/bash 
```