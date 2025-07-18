FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    kmod \
    lvm2 \
    cryptsetup-bin \
    isc-dhcp-client \
    iproute2 \
    rsync \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Configure LKCA for NVIDIA Confidential Computing
RUN mkdir -p /etc/modprobe.d && \
    echo 'install nvidia /sbin/modprobe ecdsa_generic ecdh; /sbin/modprobe --ignore-install nvidia' > /etc/modprobe.d/nvidia-lkca.conf && \
    chmod 644 /etc/modprobe.d/nvidia-lkca.conf
