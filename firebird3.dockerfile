ARG image=ubuntu:bionic
FROM $image
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq update && apt-get -qqy upgrade \
 && apt-get install -qqy firebird3.0-server \
 && gsec -modify sysdba -pw masterke \
 && echo "UserManager = Legacy_UserManager" > /etc/firebird/3.0/firebird.conf \
 && echo "WireCrypt = Enabled" >> /etc/firebird/3.0/firebird.conf \
 && echo "AuthServer = Legacy_Auth, Srp, WinSspi" >> /etc/firebird/3.0/firebird.conf \
 && rm -rf /var/lib/apt/lists/*

EXPOSE 3050/tcp

ENTRYPOINT ["/usr/sbin/fbguard"]

# Fill it with:
#COPY test.gbk /opt/
#RUN ( cd opt && gbak -c -v -user SYSDBA -password masterkey test.gbk test.gdb )

# Run it with:
# docker run -it -p 3050:3050 slavanap/firebird:3.0
