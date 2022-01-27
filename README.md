This repository connects [researchhub-backend](https://github.com/ResearchHub/researchhub-backend/) and [researchhub-web](https://github.com/ResearchHub/researchhub-web/) into one Docker-Compose to allow easy testing and development of Researchhub.
# How To Run Dockerized ResearchHub

### 1.) Install Docker & [Docker Compose](https://docs.docker.com/compose/install/).


### 2.) Clone this repository:

    git clone https://github.com/ResearchHub/researchhub-dev.git
    
### 3.) Start docker-compose

Make sure Docker is running first. This will take a little to build the first time you run it. This will launch the Django backend, Postgres Database, Redis, Elastic-Searcj, and migrate database changes.

    cd researchhub-dev
    docker-compose up -d



### 4.) Update Your Hosts File

Add the following entries to your hosts file (/etc/hosts)

    127.0.0.1	dev.researchhub.com
    127.0.0.1       dev-backend.researchhub.com

### 5.) Start Development!

Access your development ResearchHub in your browser @ https://dev.researchhub.com

The backend will be running @ https://dev-backend.researchhub.com

***




Tip: Modify environment variables by editing the ".env.dev" file in this repository.