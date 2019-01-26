# Firebird 3.0 with rfunc UDF

# Fill it with:
# gbak -c -v -user SYSDBA -password masterkey test.gbk test.gdb
# Run it with:
# docker run -itd -p 3050:3050 slavanap/firebird:3.0

ARG image=debian:buster
FROM $image as result
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq update && apt-get -qqy upgrade \
 && apt-get install -qqy firebird3.0-server \
 && gsec -modify sysdba -pw masterke \
 && echo "UserManager = Legacy_UserManager" > /etc/firebird/3.0/firebird.conf \
 && echo "WireCrypt = Enabled" >> /etc/firebird/3.0/firebird.conf \
 && echo "AuthServer = Legacy_Auth, Srp, WinSspi" >> /etc/firebird/3.0/firebird.conf \
 && rm -rf /var/lib/apt/lists/*

EXPOSE 3050/tcp
CMD ["/usr/sbin/fbguard"]

# Build rfunc
FROM result as build
RUN apt-get -qq update && apt-get install -qq --no-install-recommends \
        build-essential subversion ca-certificates firebird-dev uuid-dev
RUN svn co https://svn.code.sf.net/p/rfunc/code rfunc \
 && cd rfunc/trunk/source/ \
 && echo "GDS_NAME = fbclient" >> rfunc.conf \
 && sed -i 's/\/usr\/lib\/\(.*\).so/\/usr\/lib\/x86_64-linux-gnu\/\1.so/' makefile.linux \
 && make -f makefile.linux rfunc

FROM result
COPY --from=build /rfunc/trunk/source/rfunc /usr/lib/x86_64-linux-gnu/firebird/3.0/UDF/rfunc.so
