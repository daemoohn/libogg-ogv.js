#!/bin/sh

# getting the source code
git clone https://gitlab.xiph.org/xiph/ogg.git

# configureOgg.sh
cd ogg
if [ ! -f configure ]; then
  # generate configuration script
  sed -i.bak 's/$srcdir\/configure/#/' autogen.sh
  ./autogen.sh
fi
