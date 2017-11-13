FROM golang
RUN apt-get update -y
RUN apt-get install -y build-essential libssl-dev curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g webpack
