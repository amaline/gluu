FROM gluu-base:latest


ADD http://download.forgerock.org/downloads/opendj/20140519020002/OpenDJ-2.7.0-20140519.zip /opt/

RUN cd /opt; unzip OpenDJ-2.7.0-20140519.zip

# the following steps are only necessary because it seems like there is something funky with the perms on this folder in the forgerock zip file
RUN cd /opt/opendj/template;find config -type d -print|sed -e 's/^config/config2/'|xargs mkdir -p
RUN cd /opt/opendj/template;find config -type f -print| awk '{target=$1;sub(/^config/,"config2",target);print "cat "$1" > " target}'|sh -v
RUN cd /opt/opendj/template;rm -rf config;mv config2 config

RUN useradd opendj

ADD setup.sh /opt/opendj/

RUN cd /opt/opendj && git clone https://github.com/GluuFederation/install.git
ADD setup.properties /opt/opendj/install/

RUN chown -R opendj:opendj /opt/opendj
RUN chmod +x /opt/opendj/setup.sh


USER opendj

RUN /opt/opendj/setup --cli --baseDN o=gluu --ldapPort 1389 --adminConnectorPort 4444 --rootUserDN cn=Directory\ Manager --rootUserPassword passpass --no-prompt --noPropertiesFile

RUN /opt/opendj/bin/start-ds ;\
  cd /opt/opendj/install   ;\
  python2.7 setup.py       ;\
  /opt/opendj/bin/stop-ds


EXPOSE 1389 4444
CMD ["/opt/opendj/bin/start-ds" , "-N"]
