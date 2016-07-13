FROM ubuntu:trusty
RUN apt-get update && apt-get upgrade -y
RUN env DEBIAN_FRONTEND=noninteractive apt-get -y install heimdal-dev
RUN apt-get -y install \
	gcc \
	python-dev \
	python-pip
RUN \
	apt-get -y install software-properties-common && \
	apt-add-repository -y ppa:sssd/updates && \
	apt-add-repository -y ppa:rharwood/krb5-1.13 && \
	apt-get update && \
	env DEBIAN_FRONTEND=noninteractive apt-get -y install \
		krb5-admin-server \
		krb5-kdc \
		krb5-multidev \
		krb5-user \
		libkrb5-dev && \
	env DEBIAN_FRONTEND=noninteractive apt-get -y install \
		krb5-greet-client || true

ADD . /gssapi
WORKDIR /gssapi
RUN pip install -r test-requirements.txt .
RUN ./setup.py build
