FROM golang:1.19
LABEL maintainer=neilli-sable
###############
# General
###############
RUN apt-get update -y
RUN apt-get install -y build-essential libssl-dev curl upx sudo iproute2 unzip
###############
# Golang
###############
RUN git clone -b mygogs https://github.com/neilli-sable/dep.git $GOPATH/src/github.com/golang/dep
RUN GO111MODULE=off go get -u github.com/golang/dep/cmd/dep
RUN GO111MODULE=off go get -u github.com/jessevdk/go-assets-builder
RUN GO111MODULE=on go install github.com/golang/mock/mockgen@latest
###############
# Node & TypeScript
###############
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
RUN apt-get install -y nodejs
RUN npm install -g webpack webpack-cli
RUN npm install -g typescript
RUN npm install -g yarn
##############
# Docker
##############
RUN apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
RUN apt-get update -y
RUN apt-get install -y docker-ce
RUN curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
COPY docker-lib.sh /docker-lib.sh
##############
# AWS
##############
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install