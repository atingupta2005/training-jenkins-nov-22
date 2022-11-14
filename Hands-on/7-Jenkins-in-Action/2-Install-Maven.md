# Install maven

## Connect to Jenkins Container
```
docker exec -it -u root jenkins bash
```

## Update OS
```
apt  -y update
```

## Check if java already installed?
```
java -version
```

## Run below steps if Java not installed
```
apt install -y openjdk-8-jdk
```

## Install maven
```
mvn -v
apt install -y maven
```

## Clone Git Hub repo
```
git clone https://github.com/<your-github-account-login-id>/hello-world-maven.git
git clone https://github.com/atingupta2005/hello-world-maven.git
cd hello-world-maven/
mvn compile
```

## Deploy .jar file manually
```
cd hello-world-maven
pwd
mvn package
java -jar target/gs-maven-0.1.0.jar
```
