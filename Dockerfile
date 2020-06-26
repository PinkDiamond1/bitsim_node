FROM debian:stable-slim AS builder

WORKDIR /bitcoin

# install dependencies
RUN apt update -y && apt install libdb++-dev libboost-all-dev libevent-dev libssl-dev build-essential libtool autotools-dev automake pkg-config bsdmainutils python3 -y

COPY bitcoin-sv /bitcoin/

RUN ./autogen.sh && \
    ./configure --disable-wallet --disable-tests --disable-bench --disable-man --disable-maintainer-mode && \
    make clean && \
    make src/bitcoind 

RUN strip src/bitcoind

FROM debian:stable-slim

RUN apt update -y && apt install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-thread-dev libboost-test-dev libssl-dev libevent-dev -y

# configure directory & permissions
ENV HOME /bitcoinsv
WORKDIR /bitcoinsv
COPY --from=builder /bitcoin/src/bitcoind /bitcoinsv/bitcoind
RUN apt update -y && apt install dnsutils -y

# docker config
EXPOSE 18332-18333/tcp

ENV N_PEERS=1

### copy config
COPY bitcoin.conf /bitcoinsv/.bitcoin/bitcoin.conf
COPY entrypoint.sh /bitcoinsv/entrypoint.sh

ENTRYPOINT ["/bin/bash"]
CMD ["-c","sh entrypoint.sh"]
