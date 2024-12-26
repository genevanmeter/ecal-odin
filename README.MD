# ecal-odin

Odin bindings for [eCAL](https://github.com/eclipse-ecal/ecal) 

## Install eCAL (Linux)

See [Ubuntu](https://github.com/eclipse-ecal/ecal?tab=readme-ov-file#ubuntu)

## Run Examples

Publisher based on [samples/c/pubsub/string/minimal_snd](https://github.com/eclipse-ecal/ecal/blob/support/v5.13/samples/c/pubsub/string/minimal_snd/src/minimal_snd.c)

```
odin run examples/pubsub/string/minimal-pub.odin -file
```

Subscriber based on [samples/c/pubsub/string/minimal_rec](https://github.com/eclipse-ecal/ecal/blob/support/v5.13/samples/c/pubsub/string/minimal_rec/src/minimal_rec.c)
```
odin run examples/pubsub/string/minimal-sub.odin -file
```

Subscriber with callback based on [samples/c/pubsub/string/minimal_rec_cb](https://github.com/eclipse-ecal/ecal/blob/support/v5.13/samples/c/pubsub/string/minimal_rec_cb/src/minimal_rec_cb.c)
```
odin run examples/pubsub/string/minimal-sub-cb.odin -file
```

## (Optional) Generate Bindings


The bindings were generated via [Runic](https://github.com/Samudevv/runic) against eCAL v5.13.3.

```
wget https://github.com/Samudevv/runic/releases/download/0.5/runic-x86_64.AppImage
chmod +x runic-x86_64.AppImage
./runic-x86_64.AppImage ecal/rune.yml
# Fix a generated constants 
sed -i '/Init_All ::/ s/`//g' ecal/ecal.odin
sed -i '/Init_Default ::/ s/`//g' ecal/ecal.odin
```