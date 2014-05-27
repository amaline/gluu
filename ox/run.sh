#!/bin/bash

TOMCAT=/usr/local/apache-tomcat-7.0.54
LDAPIP=`python2.7 -c 'import socket; print socket.gethostbyname("opendj")'`

sed -i -e "s/localhost:2389/${LDAPIP}:1389/" ${TOMCAT}/conf/oxTrustCentralLdap.properties
sed -i -e "s/localhost:2389/${LDAPIP}:1389/" ${TOMCAT}/conf/oxTrustLdap.properties
sed -i -e "s/localhost:2389/${LDAPIP}:1389/" ${TOMCAT}/conf/oxauth-ldap.properties

cd /root
wget -O Gluu-Encryptor.zip http://ox.gluu.org/lib/exe/fetch.php?media=oxauth:gluu-encryptor.zip
unzip Gluu-Encryptor.zip
OPENDJPW=`java -jar /root/Gluu-Encryptor.jar passpass|awk -F: '$1 ~ /^your encrypted/{gsub(/ /,"",$2);print $2}'`

sed -i -e "/^bindPassword/s/=.*$/=${OPENDJPW}/" ${TOMCAT}/conf/oxauth-ldap.properties 
sed -i -e "/^bindPassword/s/=.*$/=${OPENDJPW}/" ${TOMCAT}/conf/oxTrustLdap.properties 
sed -i -e "/^bindPassword/s/=.*$/=${OPENDJPW}/" ${TOMCAT}/conf/oxTrustCentralLdap.properties 


${TOMCAT}/bin/startup.sh
tail -F ${TOMCAT}/logs/catalina.out
