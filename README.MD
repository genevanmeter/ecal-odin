# ecal-odin

Odin bindings for [eCAL](https://github.com/eclipse-ecal/ecal) 

## Install eCAL (Linux)

See [Ubuntu](https://github.com/eclipse-ecal/ecal?tab=readme-ov-file#ubuntu)

## Run Examples

Publisher:

```
odin run examples/pubsub/string/minimal-pub.odin -file
```

Subscriber:
```
odin run examples/pubsub/string/minimal-sub.odin -file
```

## Generate Bindings


The bindings were generated against v5.13.3.  [Runic](https://github.com/Samudevv/runic) is used to generate the bindings.

```
wget https://github.com/Samudevv/runic/releases/download/0.4/runic.linux-x86_64
chmod +x runic.linux-x86_64
./runic.linux-x86_64 ecal/rune.yml
```