# Fork from Spring PetClinic Sample Application [![Build Status](https://github.com/spring-projects/spring-petclinic/actions/workflows/maven-build.yml/badge.svg)](https://github.com/spring-projects/spring-petclinic/actions/workflows/maven-build.yml)

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/spring-projects/spring-petclinic) [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=7517918)

## Understanding the Spring Petclinic application with a few diagrams

[See the presentation here](https://speakerdeck.com/michaelisvy/spring-petclinic-sample-application)

## Run Petclinic locally

Spring Petclinic is a [Spring Boot](https://spring.io/guides/gs/spring-boot) application built using [Maven](https://spring.io/guides/gs/maven/) or [Gradle](https://spring.io/guides/gs/gradle/). You can build a jar file and run it from the command line (it should work just as well with Java 17 or newer):

#Pre-requestites
Install one test server on Ubuntu or you can run the below commands on any Linuc flavoured servers 

```bash
git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic
mvn clean install
docker build -t petclinic:latest .
docker run -p 8181:8181 petclinic:latest
docker tag petclinic:latest  <your docker registery/details>
docker push <your docker registry/details>
```

You can then access the Petclinic at <http://localhost:8181/>.

### Steps for Installation of Jenkins Server and converting the application to a docker image and push it to a registry
### Prerequisites
****All the commands are on Ubuntu 22.04TLS version
Jenkins server installation
----------------------------
sudo apt-get update -y

sudo apt-cache search openjdk

sudo apt-get install openjdk-17-jdk -y

java --version

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
  
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
  
sudo apt-get update -y

sudo apt-get install jenkins -y

sudo systemctl enable jenkins

sudo systemctl start jenkins


Maven installation

-------------------

TMP_MAVEN_VERSION=3.9.6

wget https://apache.org/dist/maven/maven-3/$TMP_MAVEN_VERSION/binaries/apache-maven-$TMP_MAVEN_VERSION-bin.tar.gz -P /tmp

sudo tar xf /tmp/apache-maven-*.tar.gz -C /opt

sudo rm /tmp/apache-maven-*-bin.tar.gz

sudo ln -s /opt/apache-maven-$TMP_MAVEN_VERSION /opt/maven

sudo touch /etc/profile.d/maven.sh

sudo chown azureuser /etc/profile.d/maven.sh

sudo bash -c 'cat << EOF > /etc/profile.d/maven.sh

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

export M2_HOME=/opt/maven

export MAVEN_HOME=/opt/maven

export PATH=/opt/maven/bin:$PATH

EOF'

Docker installation

-------------------

# Add Docker's official GPG key:

sudo apt-get update -y

sudo apt-get install ca-certificates curl gnupg -y

sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg


# Add the repository to Apt sources:

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
sudo apt-get update -y

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


sudo systemctl start docker

sudo systemctl enable docker

sudo usermod -aG docker jenkins



### Steps

1. Set up the Jenkins server as per the insturctions it will show once you access the jenkins server on https://<public IP>:8080:


2. Configure all the necessary steps to make the connectivity:

    On jenkins you can save the SAS tokens from Docker hub
    On github you can create a webhook to set up the connectivity with jenkins server
    On jenkins server you can create a decleartive pipeline with a remote file Jenkinsfile
    On jenkins server you can create another DOckerfile which provides the steps to be performed for convering the application to a docker image

3. Run the CI Pipleline :
    Commit the changes to the main branch and that will trigger a job which will do the below 5 stages
    Download the git code
    Build the package using mvn command
    Build a docker image
    Push the docker image to a repository of our choice

## License

The Spring PetClinic sample application is released under version 2.0 of the [Apache License](https://www.apache.org/licenses/LICENSE-2.0).
