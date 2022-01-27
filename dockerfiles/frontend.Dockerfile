FROM node:11-alpine

RUN apk add tar gzip yarn curl bash git
RUN touch ~/.bashrc && chmod +x ~/.bashrc
SHELL ["/bin/bash", "--login", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN . ~/.nvm/nvm.sh && source ~/.bashrc && nvm install node

RUN git clone -b connerdev https://github.com/ResearchHub/researchhub-web.git
WORKDIR /researchhub-web/

RUN npm install
