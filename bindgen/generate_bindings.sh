#!/bin/bash

ECAL_CORE="${1:-/usr/include/ecal_c}"

cp -R $ECAL_CORE .

patch -p0 < patchfile.patch

rm -rf config/config
../../odin-c-bindgen/bindgen config/
cd config/config 
for f in *.odin; do mv "$f" "${f%.odin}_config.odin"; done
cd -


rm -rf pubsub/pubsub
../../odin-c-bindgen/bindgen pubsub/
cd pubsub/pubsub
for f in *.odin; do mv "$f" "${f%.odin}_pubsub.odin"; done
cd -

rm -rf service/service
../../odin-c-bindgen/bindgen service/
cd service/service
for f in *.odin; do mv "$f" "${f%.odin}_service.odin"; done
cd -

rm -rf types/types
../../odin-c-bindgen/bindgen types/
cd types/types
for f in *.odin; do mv "$f" "${f%.odin}_types.odin"; done
cd -

patch -p0 < output.patch


../../odin-c-bindgen/bindgen .