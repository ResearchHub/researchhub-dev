This repository connects [researchhub-backend](https://github.com/ResearchHub/researchhub-backend/) and [researchhub-web](https://github.com/ResearchHub/researchhub-web/) into one Docker-Compose to allow easy testing and development of Researchhub.
# How To Run Dockerized ResearchHub

### 1.) Install Docker & [Docker Compose](https://docs.docker.com/compose/install/).


### 2.) Clone neccessary repositories:

    # Clone and enter this repository
    git clone https://github.com/ResearchHub/researchhub-dev.git
    cd researchhub-dev

    # Clone frontend and backend into researchhub-dev
    git clone -b connerdev https://github.com/ResearchHub/researchhub-backend.git
    git clone -b connerdev https://github.com/ResearchHub/researchhub-web.git
    cp -R researchhub-backend/src/config/* researchhub-backend/src/config_local/

    # Start Docker
    docker-compose up -d
    

### 3.) Update Your Hosts File

Add the following entries to your hosts file (/etc/hosts)

    127.0.0.1	dev.researchhub.com
    127.0.0.1       dev-backend.researchhub.com

### 4.) Start Development!

Access your development ResearchHub in your browser @ https://dev.researchhub.com

The backend will be running @ https://dev-backend.researchhub.com

***




Tip: Modify environment variables by editing the ".env.dev" file in this repository.