FROM ubuntu:bionic as emu
RUN apt-get update -qq && apt-get install -qq --no-install-recommends qemu-user-static

FROM resin/rpi-raspbian:stretch as final
COPY --from=emu /usr/bin/qemu-arm-static /usr/bin/qemu-arm-static
