
FROM jenkins/jenkins:lts-jdk21

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates \
    && curl -fsSL https://get.docker.com -o /tmp/get-docker.sh \
    && sh /tmp/get-docker.sh \
    && docker --version \
    && rm -f /tmp/get-docker.sh \
    && rm -rf /var/lib/apt/lists/*

USER jenkins
