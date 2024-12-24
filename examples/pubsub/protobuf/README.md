
## Run
Publisher
```
odin run person-snd.odin -file
```
eCAL Version
```
ecal_sample_person_snd
```

Receiver
```
odin run person-rec.odin -file
```
eCAL Version
```
ecal_sample_person_rec
```


### proto to odin gen w/ descriptor 

```
protoc --odin_out=. -o proto.desc *.proto
```

