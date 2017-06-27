FROM debian

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update \
 && apt-get install -yqq \
	vim-tiny \
	tcpdump \
	ngrep \
	git \
	python \
	python-twisted \
 && apt-get -yqq clean \
 && rm -rf /var/lib/apt/lists/*

ENV ETH_PROXY_VERSION="0.0.5"
RUN cd /home \
 && git clone -b ${ETH_PROXY_VERSION} --depth 1 https://github.com/Atrides/eth-proxy \
 && cd eth-proxy

WORKDIR /home/eth-proxy

COPY resources/eth-proxy.conf eth-proxy.conf
COPY resources/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ADD https://github.com/kreuzwerker/envplate/releases/download/v0.0.8/ep-linux /usr/local/bin/ep
RUN chmod +x /usr/local/bin/* && chmod +x eth-proxy.py

ENV ETH_ADDRESS="0x8d3c63a5121d346642e83b69a57a959abfb73812"

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["/home/eth-proxy/eth-proxy.py"]