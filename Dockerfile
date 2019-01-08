# Developer: Max Deviam <info@deviam.de>
#
# GitHub:  https://github.com/deviammx/
# Docker:  https://hub.docker.com/u/deviam

FROM alpine:3.8

LABEL com.frapsoft.maintainer="Max Deviam" \
      com.deviam.version="0.1.0"

# Optional Configuration Parameter
ARG SERVICE_USER
ARG SERVICE_HOME

# Default Settings
ENV SERVICE_USER ${SERVICE_USER:-download}
ENV SERVICE_HOME ${SERVICE_HOME:-/home/${SERVICE_USER}}

RUN \
  adduser -h ${SERVICE_HOME} -s /sbin/nologin -u 1000 -D ${SERVICE_USER} && \
  apk add --no-cache \
    curl \
    bash \
    coreutils \
    dumb-init \
    openssl

USER    ${SERVICE_USER}
WORKDIR ${SERVICE_HOME}
VOLUME  ${SERVICE_HOME}

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "curl", "--help" ]
