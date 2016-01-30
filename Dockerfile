###################################################################################################

FROM katherinealbany/athena:stable

###################################################################################################

MAINTAINER Katherine Albany

###################################################################################################

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install --no-install-recommends --quiet --yes ca-certificates wget

###################################################################################################

USER    ${USER}
WORKDIR ${HOME}

###################################################################################################

ENV URL    https://releases.hashicorp.com/consul/0.6.3/consul_0.6.3_linux_amd64.zip
ENV SHA256 fd8bbbb0125f58990004bcd96fb16afb2ae5d30f157f64bd7dd298df74b03b48

###################################################################################################

RUN wget --progress=dot:binary --output-document=- ${URL} | uncompress > consul                   \
 && echo "${SHA256} consul" | sha256sum --strict --check --quiet                                  \
 && chown ${USER}:${USER} consul                                                                  \
 && chmod 700 consul

###################################################################################################

EXPOSE 8300/tcp 8301/tcp 8301/udp 8302/tcp 8302/udp 8400/tcp 8500/tcp 8600/tcp 8600/udp

###################################################################################################

ENTRYPOINT ["./consul"]

###################################################################################################

CMD ["--help"]

###################################################################################################
