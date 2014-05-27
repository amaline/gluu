FROM centos:latest

RUN yum -y install tar gzip which git unzip zlib-devel bzip2-devel openssl-devel xz-libs wget svn xz; yum clean all
ADD http://mirror.cc.columbia.edu/pub/software/apache/maven/maven-3/3.2.1/binaries/apache-maven-3.2.1-bin.tar.gz /usr/local/
ADD http://www.gtlib.gatech.edu/pub/apache/tomcat/tomcat-7/v7.0.54/bin/apache-tomcat-7.0.54.tar.gz  /usr/local/
RUN cd /usr/local;tar -zxvf apache-maven-3.2.1-bin.tar.gz;tar -zxvf apache-tomcat-7.0.54.tar.gz
ENV M2_HOME /usr/local/apache-maven-3.2.1
ENV M2 /usr/local/apache-maven-3.2.1/bin
RUN (echo 'export PATH=$M2:$PATH' > /etc/profile.d/mvn.sh )

# python 2.7.6 install
RUN wget http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tar.xz
RUN yum -y install xz;yum clean all
RUN xz -d Python-2.7.6.tar.xz
RUN tar -xvf Python-2.7.6.tar
RUN yum groupinstall -y 'development tools';yum clean all
RUN cd Python-2.7.6;\
    ./configure --prefix=/usr/local;\
    make;\
    make altinstall;\
    /usr/local/bin/python2.7 -V

# JDK 7
RUN cd /opt ; wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u55-b13/jdk-7u55-linux-x64.tar.gz ;tar -zxvf *.tar.gz
RUN alternatives --install /usr/bin/java java /opt/jdk1.7.0_55/bin/java 2
RUN alternatives --set java /opt/jdk1.7.0_55/bin/java
ADD java.sh /etc/profile.d/

CMD ["/bin/bash"]
