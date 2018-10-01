FROM openjdk:8-jre-alpine

ENV PATH /usr/local/tomee/bin:$PATH
RUN mkdir -p /usr/local/tomee

WORKDIR /usr/local/tomee

RUN set -x \
	&& apk add --update curl \
	&& rm -rf /var/cache/apk/* \
	&& curl -fSL https://repo.maven.apache.org/maven2/org/apache/tomee/apache-tomee/7.0.5/apache-tomee-7.0.5-plus.tar.gz -o tomee.tar.gz \
        && tar -zxf tomee.tar.gz \
	&& mv apache-tomee-plus-7.0.5/* /usr/local/tomee \
	&& mv /usr/local/tomee/conf/tomcat-users.xml /usr/local/tomee/conf/tomcat-users.xml.old \
	&& curl -fSL https://raw.githubusercontent.com/switek/tomee-openshift/master/xml/tomcat-users.xml -o /usr/local/tomee/conf/tomcat-users.xml \
	&& rm -rf apache-tomee-plus-7.0.5 \
	&& rm bin/*.bat \
	&& rm tomee.tar.gz*
	
EXPOSE 8080
CMD ["catalina.sh", "run"]
