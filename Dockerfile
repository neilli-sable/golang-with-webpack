FROM golang
LABEL maintainer=neilli-sable
###############
# General
###############
RUN apt-get update -y
RUN apt-get install -y build-essential libssl-dev curl upx
###############
# Golang
###############
RUN git clone -b mygogs https://github.com/neilli-sable/dep.git $GOPATH/src/github.com/golang/dep
RUN go get -u github.com/golang/dep/cmd/dep
RUN go get -u github.com/jessevdk/go-assets-builder
###############
# Node & TypeScript
###############
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g webpack webpack-cli
RUN npm install -g typescript
###############
# Elm
###############
RUN wget "https://github.com/elm/compiler/releases/download/0.19.0/binaries-for-linux.tar.gz"
RUN tar xzf binaries-for-linux.tar.gz
RUN mv elm /usr/local/bin/
##############
# Docker
##############
RUN apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
RUN apt-get update -y
RUN apt-get install -y docker-ce
RUN sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
COPY docker-lib.sh /docker-lib.sh
