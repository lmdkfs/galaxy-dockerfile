FROM centos:7.5.1804
LABEL maintainer="zhuruiqing@finupgroup.com" \
      provider="Finup FinTech Group Co., Ltd." \
      centos="7.5.1804" \
      extendfonts="simsun" \
      python="2.7.5"

ADD jdk1.8.0_211 /usr/local/jdk1.8.0_211
ADD fonts /usr/share/fonts

ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8"

ENV JAVA_VERSION="1.8.0_211"

ENV JAVA_HOME="/usr/local/jdk${JAVA_VERSION}"

ENV PATH="${PATH}:${JAVA_HOME}/bin"

# Do not use alias cp
RUN \cp  /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  \
    && yum update -y \
    && yum install -y curl bind-utils telnet fontconfig net-tools \
    && fc-cache \
    && yum clean all
