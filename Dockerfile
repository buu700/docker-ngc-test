FROM google/cloud-sdk

MAINTAINER Ryan Lester <hacker@linux.com>

LABEL Name="docker-ngc-test"

RUN apt-get -y --force-yes update
RUN apt-get -y --force-yes install curl lsb-release apt-transport-https

RUN echo " \
	deb https://deb.nodesource.com/node_6.x $(lsb_release -c | awk '{print $2}') main \
" >> /etc/apt/sources.list
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

RUN apt-get -y --force-yes update
RUN apt-get -y --force-yes dist-upgrade

RUN apt-get -y --force-yes install build-essential git nano nodejs

RUN npm -g install \
	@angular/common \
	@angular/compiler \
	@angular/compiler-cli \
	@angular/core \
	@angular/platform-browser \
	@angular/platform-server \
	rxjs \
	typescript \
	typings \
	zone.js

RUN git clone https://github.com/angular/quickstart.git
RUN cd quickstart ; npm install ; npm run postinstall
RUN sed -i 's|template:|templateUrl: "balls.html" //|' quickstart/app/app.component.ts
RUN wget https://www.reddit.com -O quickstart/app/balls.html

VOLUME /test
WORKDIR /test
CMD /bin/bash
