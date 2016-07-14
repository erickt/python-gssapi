FROM ubuntu:xenial

WORKDIR /root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install --no-install-recommends -y \
		build-essential \
		ca-certificates \
		curl \
		file \
		xutils-dev

RUN \
	apt-get -y install \
		krb5-admin-server \
		krb5-kdc \
		krb5-multidev \
		krb5-user \
		libkrb5-dev \
		gcc \
		python-dev \
		python-pip

ADD . /gssapi
WORKDIR /gssapi
RUN pip install -r test-requirements.txt .
RUN ./setup.py build
