FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 ubuntu && \
    echo 'ubuntu:ubuntu' | chpasswd

RUN apt-get update && \
    apt-get install -yqq --no-install-recommends locales=2.* ssh=1:8.* sudo=1.8.* && \
    apt-get clean all && \
    mkdir /run/sshd && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    echo "ubuntu ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu && \
    rm -rf /var/lib/apt/lists/

EXPOSE 22

ENTRYPOINT ["/usr/sbin/sshd", "-D" ]
