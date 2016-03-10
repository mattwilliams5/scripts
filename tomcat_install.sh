#!/bin/bash

# This script will successfully download and install latest version of jdk and tomcat7


if [ `whoami` != 'root' ]
then
    echo "Must be root to run this script!"
    exit 1
fi

# Begin Java installation
install_java ()
{ JAVA_INSTALL=$(wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz)
  $JAVA_INSTALL
  tar zxvf jdk*
  mv jdk1*/ /opt
  ls /opt | grep jdk*
  if [ $? == 0 ]
  then
      echo "JDK installed successfully"
  else
      echo "Java Install Failed"
  fi
  alternatives  --install /usr/bin/java java /opt/jdk1.7.0.79/bin/java 2
  alternatives  --config java 
  # Check your version
  java -version
  alternatives --install /usr/bin/jar jar /opt/jdk1.7.0.79/bin/jar 2
  alternatives --install /usr/bin/javac javac /opt/jdk1.7.0.79/bin/javac 2
  alternatives --set jar /opt/jdk1.7.0.79/bin/jar
  alternatives --set javac /opt/jdk1.7.0.79/bin/javac
  # Make sure jar and javac are available on the cli
  jar
  javac
  # Set Env Vars
  export JAVA_HOME=/opt/jdk1.7.0.79
  export JAVA_HOME=/opt/jdk1.7.0.79
  export JRE_HOME=/opt/jdk1.7.0.79/jre
  export PATH=$PATH:/opt/jdk1.7.0.79/bin/:/opt/jdk1.7.0.79/jre/bin/
  # Set up script to maintain all vars
  touch /etc/profile.d/java.sh
  echo "export JAVA_HOME=/opt/jdk1.7.0.79" >> /etc/profile.d/java.sh
  echo "export JAVA_HOME=/opt/jdk1.7.0.79" >> /etc/profile.d/java.sh
  echo "export JRE_HOME=/opt/jdk1.7.0.79/jre" >> /etc/profile.d/java.sh
  echo "export PATH=$PATH:/opt/jdk1.7.0.79/bin/:/opt/jdk1.8.0_45/jre/bin/" >> /etc/profile.d/java.sh
  # Check your work
  env | grep -i java && env | grep -i jre
}  

install_tomcat()
{ # Install Tomcat finally!
  TOMCAT_INSTALL=$(wget http://mirror.cogentco.com/pub/apache/tomcat/tomcat-7/v7.0.63/bin/apache-tomcat-7.0.63.tar.gz)
  tar zxvf apache-tomcat-7.0.63.tar.gz
  # Move Tomcat to /opt
  mv /home/matt/Downloads/apache-tomcat-7.0.63 /opt
  # Start Tomcat
  cd /opt/apache-tomcat-7.0.63/bin/
  ./startup.sh
  # Check Running Process
  ps aux | grep tomcat 
  # Check to see the welcome page on cli
  curl http://localhost:8080
}

echo "Would you like to install JDK: Yes/No"
read ans

if [ $ans == "Yes" ]
then
    install_java
    install_tomcat
else
    install_tomcat
fi
