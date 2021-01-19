FROM debian:buster

WORKDIR /usr/src/app

RUN \
apt-get update && apt-get install -y --no-install-recommends  ca-certificates netbase curl gnupg2 \
        && rm -rf /var/lib/apt/lists/*  \
		&& echo 'deb https://dl.yarnpkg.com/debian/ stable main' >/etc/apt/sources.list.d/yarn.list \
		&& curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -

RUN \
apt update && apt install -y wget git build-essential make nodejs yarn automake cmake libpcre3 npm libpcre3-dev re2c zlib1g-dev apt-transport-https ca-certificates

COPY package.json yarn.lock ./
COPY start.sh /
COPY . .


RUN \
cd /usr/src/app && yarn install && yarn lint && yarn format:check && yarn test && yarn test:cov && yarn test:e2e \
&& chmod 0777 /start.sh

EXPOSE 3000
CMD [ "/start.sh" ]
