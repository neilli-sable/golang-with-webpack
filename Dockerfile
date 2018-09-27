FROM golang
RUN apt-get update -y
RUN apt-get install -y build-essential libssl-dev curl upx
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g webpack webpack-cli
RUN npm install -g typescript
RUN git clone -b mygogs https://github.com/neilli-sable/dep.git $GOPATH/src/github.com/golang/dep
RUN go get -u github.com/golang/dep/cmd/dep
RUN go get -u github.com/jessevdk/go-assets-builder
