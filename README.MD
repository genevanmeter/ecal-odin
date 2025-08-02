# ecal-odin

Odin bindings for [eCAL v6](https://github.com/eclipse-ecal/ecal) 

Odin Version [dev-2025-07](https://github.com/odin-lang/Odin/releases/tag/dev-2025-07)

## Install eCAL (Linux)

See [Ubuntu](https://eclipse-ecal.github.io/ecal/v6.0/getting_started/setup.html#fa-ubuntu-installing-ecal-on-ubuntu)

## Run Examples

Publisher based on [c/samples/pubsub/string/hello_send](https://github.com/eclipse-ecal/ecal/tree/v6.0.0/lang/c/samples/pubsub/string/hello_send)

```
odin run examples/pubsub/string/hello_send.odin -file
```

Subscriber with callback based on [c/samples/pubsub/string/hello_receive](https://github.com/eclipse-ecal/ecal/tree/v6.0.0/lang/c/samples/pubsub/string/hello_receive)
```
odin run examples/pubsub/string/hello_receive.odin -file
```

## (Optional) Generate Bindings

The bindings were generated via [Odin-C-Bindgen](https://github.com/karl-zylinski/odin-c-bindgen) against eCAL v6.0.0


```
cd bindgen
./generate_bindings.sh PATH_TO_ECAL_C_HEADERS
```