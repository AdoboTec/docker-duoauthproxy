FROM ubuntu:22.04 AS builder

WORKDIR /opt

RUN apt update -y && \
    apt-get -y install build-essential libffi-dev perl zlib1g-dev curl tar

RUN cd /opt && \
    curl https://dl.duosecurity.com/duoauthproxy-5.7.4-src.tgz -o duoauthproxy-5.7.4-src.tgz && \
    tar xzf duoauthproxy-5.7.4-src.tgz && \
    rm -rf duoauthproxy-5.7.4-src.tgz && \
    cd /opt/duoauthproxy-5.7.4* && \
    make && \
    cd duoauthproxy-build && \
    ./install --install-dir /opt/duoauthproxy --service-user duo_authproxy_svc --log-group duo_authproxy_grp --silent && \
    rm -rf /opt/duoauthproxy-5.7.4* && \
    ls -lash /opt/

FROM ubuntu:22.04

WORKDIR /opt

COPY --from=builder /opt/ /opt/

COPY docker-entrypoint /

RUN apt update -y && \
    apt-get -y install openssl

RUN rm -rf /opt/duoauthproxy/conf/authproxy.cfg && \
    ln -s /config/authproxy.cfg /opt/duoauthproxy/conf/authproxy.cfg

RUN addgroup duo_authproxy_grp --gid 1001 && \ 
    adduser duo_authproxy_svc --ingroup duo_authproxy_grp --uid 1001

RUN chown -R duo_authproxy_svc:duo_authproxy_grp /opt/ && \
    chmod +x /docker-entrypoint 

USER duo_authproxy_svc:duo_authproxy_grp

EXPOSE 1636

# Docker EntryPoint
ENTRYPOINT ["/docker-entrypoint"]

# Run server command from docker-entrypoint
CMD ["duoproxy"]

