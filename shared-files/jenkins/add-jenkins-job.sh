#!/bin/bash

# 
# Create Jenkins job
# 

echo "* Import job"
java -jar /home/vagrant/jenkins-cli.jar -s http://192.168.99.201:8080/ -http -auth admin:admin delete-job exam
java -jar /home/vagrant/jenkins-cli.jar -s http://192.168.99.201:8080/ -http -auth admin:admin create-job exam < /vagrant/jenkins/exam.xml

echo "* Build job"
java -jar /home/vagrant/jenkins-cli.jar -s http://192.168.99.201:8080/ -http -auth admin:admin build exam
