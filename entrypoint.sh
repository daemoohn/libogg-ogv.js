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

# compileOggJs.sh

# set up the build directory
mkdir -p build
cd build

mkdir -p js
cd js

mkdir -p root
mkdir -p libogg
cd libogg

# finally, run configuration script
emconfigure ../../../ogg/configure \
    --prefix="$dir/build/js/root" \
    --disable-shared \
|| exit 1

# compile libogg
emmake make -j4 || exit 1
emmake make install || exit 1
