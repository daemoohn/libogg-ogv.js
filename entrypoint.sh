#!/bin/sh

## getting the source code
git clone https://gitlab.xiph.org/xiph/ogg.git

## get version tag
cd ogg
version=`git describe --tags`
cd ..
## configureOgg.sh

cd ogg
if [ ! -f configure ]; then
  # generate configuration script
  sed -i.bak 's/$srcdir\/configure/#/' autogen.sh
  ./autogen.sh
fi
cd ..

## compileOggJs.sh
dir=`pwd`

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

cd $dir

## upload to bintray
zip -r libogg-ogv.js.zip $dir/build/js/root 
curl -T libogg-ogv.js.zip -u$1:$2 https://api.bintray.com/content/daemoohn/libogg-ogv.js/libogg-ogv.js/$version/libogg-ogv.js.zip?publish=1
