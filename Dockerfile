FROM openjdk:8-jre

ENV PATH /usr/local/tomee/bin:$PATH
RUN mkdir -p /usr/local/tomee

WORKDIR /usr/local/tomee

RUN set -x \
	&& curl -fSL https://repo.maven.apache.org/maven2/org/apache/tomee/apache-tomee/7.0.5/apache-tomee-7.0.5-plus.tar.gz.asc -o tomee.tar.gz.asc \
	&& curl -fSL https://repo.maven.apache.org/maven2/org/apache/tomee/apache-tomee/7.0.5/apache-tomee-7.0.5-plus.tar.gz -o tomee.tar.gz \
        && gpg --batch --verify tomee.tar.gz.asc tomee.tar.gz \
	&& tar -zxf tomee.tar.gz \
	&& mv apache-tomee-plus-7.0.5/* /usr/local/tomee \
	&& rm -Rf apache-tomee-plus-7.0.5 \
	&& rm bin/*.bat \
	&& rm tomee.tar.gz* \
	&& cp -f xml/tomcat-users.xml /usr/local/tomee/conf \
	&& mv /usr/local/tomee/tomcat-users.xml /usr/local/tomee/tomcat-users.xml.old \
	&& curl -fSL https://github.com/switek/tomee-openshift/blob/master/xml/tomcat-users.xml -o /usr/local/tomee/tomcat-users.xml


EXPOSE 8080
CMD ["catalina.sh", "run"]
