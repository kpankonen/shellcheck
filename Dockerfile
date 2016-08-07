FROM ubuntu:xenial
MAINTAINER https://github.com/koalaman/shellcheck

ENV PATH="/root/.cabal/bin:/usr/local/bin:$PATH"

COPY . /src

WORKDIR /src

RUN apt-get update && apt-get install --no-install-recommends -y cabal-install \
 && cabal update \
 && cabal install --only-dependencies \
 && cabal install --global \
 && rm -rf /root/.cabal \
 && apt-get remove -y cabal-install \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

CMD ["shellcheck", "-"]
