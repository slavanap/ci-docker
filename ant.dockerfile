FROM openjdk

LABEL maintainer "Vyacheslav Napadovsky" <napadovskiy@gmail.com>

RUN (cd /opt \
    && wget --progress=dot -e dotbytes=1M \
        https://www.apache.org/dist/ant/KEYS \
        https://www.apache.org/dist/ant/binaries/apache-ant-1.10.5-bin.zip.asc \
        http://apache-mirror.rbc.ru/pub/apache//ant/binaries/apache-ant-1.10.5-bin.zip \
    && gpg --import KEYS \
    && gpg --verify apache-ant-1.10.5-bin.zip.asc \
    && unzip -q apache-ant-1.10.5-bin.zip \
    && rm KEYS apache-ant-1.10.5-bin.zip.asc apache-ant-1.10.5-bin.zip \
)

RUN (cd /opt \
    && wget https://github.com/junit-team/junit4/releases/download/r4.12/junit-4.12.jar \
    && wget https://search.maven.org/remotecontent?filepath=org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar -O hamcrest-core-1.3.jar \
    && mkdir junit && unzip -q hamcrest-core-1.3.jar -d junit && unzip -qo junit-4.12.jar -d junit \
    && rm junit-4.12.jar hamcrest-core-1.3.jar \
)

ENV PATH="$PATH:/opt/apache-ant-1.10.5/bin" JUNIT_PATH=/opt/junit
