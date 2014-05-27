FROM gluu-base

RUN yum -y install svn
RUN mkdir /usr/local/src/ox
RUN cd /usr/local/src/ox	;\
    svn --non-interactive --trust-server-cert co https://svn.gluu.info/repository/openxdi/install ox_install	;\
    svn --non-interactive --trust-server-cert co https://svn.gluu.info/repository/openxdi/oxAuth		;\
    svn --non-interactive --trust-server-cert co https://svn.gluu.info/repository/openxdi/oxTrust

ADD setup.properties /usr/local/src/ox/ox_install/branches/release1.0.0/
#ADD setup.properties2 /usr/local/src/ox/ox_install/trunk/

#RUN . /etc/profile.d/java.sh; . /etc/profile.d/mvn.sh; cd /usr/local/src/ox/ox_install/trunk; python2.7 setup.py
RUN . /etc/profile.d/java.sh; . /etc/profile.d/mvn.sh; cd /usr/local/src/ox/ox_install/branches/release1.0.0; python2.7 setup.py
ADD run.sh /root/

# add extra logging information
ADD logging.properties /root/WEB-INF/classes/
RUN . /etc/profile.d/java.sh;cd /root; jar -uf /usr/local/apache-tomcat-7.0.54/webapps/oxTrust.war WEB-INF/classes/logging.properties

VOLUME /usr/local/src/ox

EXPOSE 8080

CMD ["/root/run.sh"]
