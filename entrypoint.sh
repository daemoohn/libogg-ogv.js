#!/bin/sh
git clone https://gitlab.xiph.org/xiph/ogg.git
cd ogg
if [ ! -f configure ]; then
  # generate configuration script
  sed -i.bak 's/$srcdir\/configure/#/' autogen.sh
  ./autogen.sh
fi
