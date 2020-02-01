# Starting off with the Jenkins base Image
FROM jenkins/jenkins:2.204.2

# Installing the plugins we need using the in-built install-plugins.sh script
RUN /usr/local/bin/install-plugins.sh \
        git:4.1.1 \
        workflow-aggregator:2.6 \
        docker-workflow:1.16 \
        credentials-binding:1.20 \
        maven-plugin:3.4 \
        warnings-ng:7.3.0 \
        docker-commons:1.15 \
        role-strategy:2.13 \
        discard-old-build:1.05 \
        email-ext:2.68 \
        pipeline-utility-steps:2.5.0 \
        checkmarx:8.90.4 \
        tasks:4.53 \
        ssh-agent:1.19 \
        ssh-slaves:1.31.1 \
        pipeline-maven:3.8.2

# Setting up environment variables for Jenkins admin user
ENV JENKINS_USER jenkins
ENV JENKINS_PASS jenkins

# Skip the initial setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV JENKINS_JAVA_OPTIONS -Duser.timezone=America/New_York

ENV JENKINS_OPTS="--handlerCountMax=300 --logfile=/var/log/jenkins/jenkins.log --webroot=/var/cache/jenkins/war"

# Set timezone to EST
ENV TZ America/New_York

# Start-up scripts to set number of executors and creating the admin user
COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/

VOLUME /var/jenkins_home

USER root

RUN mkdir /var/log/jenkins
RUN mkdir /var/cache/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins
RUN chown -R jenkins:jenkins /var/cache/jenkins
