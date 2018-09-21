FROM ubuntu:bionic AS emu
RUN apt-get update -qq && apt-get install -qq --no-install-recommends qemu-user-static

FROM arm32v7/ubuntu:xenial as final
COPY --from=emu /usr/bin/qemu-arm-static /usr/bin/qemu-arm-static
