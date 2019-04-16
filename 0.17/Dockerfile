ARG IMAGE

FROM ${IMAGE}

# Not sure why this needs to be declared after the IMAGE
ARG QTUM_ARCH

LABEL maintainer.0="David Michael"

ENV QTUM_VERSION=0.17.3

RUN useradd -r qtum \
  && apt-get update -y \
  && apt-get install -y curl git build-essential \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/ncopa/su-exec.git \
  && cd su-exec && make && cp su-exec /usr/local/bin/ \
  && cd .. && rm -rf su-exec

RUN echo https://github.com/qtumproject/qtum/releases/download/mainnet-ignition-v${QTUM_VERSION}/qtum-${QTUM_VERSION}-${QTUM_ARCH}-linux-gnu.tar.gz

RUN curl -SLO https://github.com/qtumproject/qtum/releases/download/mainnet-ignition-v${QTUM_VERSION}/qtum-${QTUM_VERSION}-${QTUM_ARCH}-linux-gnu.tar.gz \
  && tar --strip=2 -xzf *.tar.gz -C /usr/local/bin \
  && rm *.tar.gz

COPY entrypoint.sh /entrypoint.sh

VOLUME ["/home/qtum/.qtum"]

EXPOSE 3888 3889

ENTRYPOINT ["/entrypoint.sh"]

CMD ["qtumd"]
