FROM ubuntu:bionic

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && apt-get install -qqy --no-install-recommends ca-certificates wget unzip \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir /data && cd /data && wget -nv \
        http://host.robots.ox.ac.uk/pascal/VOC/download/tud.tar.gz           \
        http://host.robots.ox.ac.uk/pascal/VOC/download/uiuc.tar.gz          \
        http://host.robots.ox.ac.uk/pascal/VOC/download/voc2005_1.tar.gz     \
        http://host.robots.ox.ac.uk/pascal/VOC/download/voc2005_2.tar.gz     \
        http://host.robots.ox.ac.uk/pascal/VOC/download/voc2006_trainval.tar \
        http://host.robots.ox.ac.uk/pascal/VOC/download/voc2006_test.tar     \
        http://host.robots.ox.ac.uk/pascal/VOC/download/caltech.tar.gz       \
        http://host.robots.ox.ac.uk/pascal/VOC/download/mit-000.tar.gz       \
        http://host.robots.ox.ac.uk/pascal/VOC/download/mit-001.tar.gz       \
        http://host.robots.ox.ac.uk/pascal/VOC/download/tug.tar.gz           \
        http://host.robots.ox.ac.uk/pascal/VOC/download/101objects.tar.gz    \
 && echo '\
613b67ea74d6907a30a82db456b5a962b2dbc1ea43555c1aa535bb792e8c48670efaa276b877070f12d9714beeebd75a82948e6ddb0669e9dad467b86cfc94c8 *101objects.tar.gz\n\
3b7da2228b8fd50dee610ff93bfd7950cfdd4717320697e7d67d76c539ccdff11d6bb499f87eb68763c32ce36618b79ddf851e86829fcde672945ab8a4e47993 *caltech.tar.gz\n\
62689870a010f67d64ac9a03ba0efc3daeb677064bd9ba730626a1ee3af2174aa081e4fbaee0df184eafc70ecadf2013121dd3f671b60ab11695b48c47c20463 *mit-000.tar.gz\n\
213a5a4afb26908061dacadaea3437dcb987265431a1a6fd535ed923501d01543a0265e9d02c15708cfde98d18e9e8d2c9eb39cb5504834dcc9452c9472d11a9 *mit-001.tar.gz\n\
e462e4274fd40320d4b07ebdfcc23129bd867a4cd8da4cdfe2ffc844054eef573fcfd5ac462901f1779eb95bcfc20aed0ed65e51e91d2b6734d63182772ae107 *tud.tar.gz\n\
eeadadbf5e6c6e8080f14db6569b67faa7faf210e77c0bfd4be139622fc85b1450799aa7c862228063b0f7dec192de755e9e49967beea8d88b86a9c081f2f106 *tug.tar.gz\n\
2c4f8220e0978d095e9c10613f60c9a73a91a61556167c82891e3fff80037878b5cde57dfb0127126ffa3ee4a9c110a5a3dd9a1474e455b8e580f8f53751ebf5 *uiuc.tar.gz\n\
cacbe2cf75f5f9217c90ef353cc5533d176907bf1f05138e9046f2477e45a9af25aa2f3dd92917f417ee899e81a0fc2d67476bf48a524354fff520c040dcd5c1 *voc2005_1.tar.gz\n\
9cc1d7786fd7763fab6154025bf9f9399c3fd1849da077b31fbe98909df7a85ae60b8a98d5d54d7b3b682d4efe0bc040772e7e22eb4a41563862776881e19748 *voc2005_2.tar.gz\n\
8a4f26dffa648e7cdfc4f710b201ebfa8911e31a10e8517d01125acc2e0c8f60ee888190bb35e9a6ffd764bcd8a51809fec2f571c478e9e8e352161edbb3513f *voc2006_test.tar\n\
69239a732268ca58f58b3f34bf632770e3e3c442f0032c80f48080b35de293184b62c084c5cacb8f03ce7cafd2dcd518497dc247455fad6bddd25846b4c2ac78 *voc2006_trainval.tar\n\
' > sums.sha512 \
 && sha512sum -c sums.sha512 \
 && for f in *.tar *.tar.gz; do tar xf "$f" && rm "$f"; done
