// Auto-generated by odin-protoc-plugin (https://github.com/lordhippo/odin-protoc-plugin)
// protoc version: 3.21.12
// Use with the runtime odin-protobuf library (https://github.com/lordhippo/odin-protobuf)

package proto_example


Person :: struct {
  id : i32 `id:"1" type:"5"`,
  name : string `id:"2" type:"9"`,
  stype : Person_SType `id:"3" type:"14"`,
  email : string `id:"4" type:"9"`,
  dog : Dog `id:"5" type:"11"`,
  house : House `id:"6" type:"11"`,
}

Person_SType :: enum {
  MALE = 0,
  FEMALE = 1,
}