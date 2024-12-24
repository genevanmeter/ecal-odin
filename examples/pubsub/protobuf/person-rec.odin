package person_snd


import "core:os"
import "core:fmt"
import "core:c"
import "core:strings"
import "core:mem"


import eCAL "../../../ecal"

import "odin-protobuf/protobuf"
import "protos"

main ::proc(){
    args: = os.args

    argc: = len(args)
    argv: = make([dynamic] cstring, argc)
    defer delete (argv)

    for i in 0 ..< argc {
        argv[i] = strings.unsafe_string_to_cstring(args[i])
    }

    version_str := eCAL.GetVersionString()
    version_date_str := eCAL.GetVersionDateString()

    fmt.printfln("eCAL Version: %s\nBuild Date: %s\n",version_str, version_date_str)

    eCAL.Initialize(cast(c.int)argc, cast(^cstring)(&argv[0]), "person subscriber", eCAL.eCAL_Init_Default)

    descriptor, ok := os.read_entire_file("./protos/proto.desc", context.allocator)
	if !ok {
		// could not read file
		return
	}
	defer delete(descriptor, context.allocator)

    descriptor_cstr := strings.clone_to_cstring(string(descriptor))

    sub := eCAL.Sub_New()
    
    eCAL.Sub_Create(sub, "person", "proto:pb.People.Person", descriptor_cstr, i32(len(descriptor_cstr)))

    for {
        if eCAL.Ok() == 0 do break

        rcv_buf : rawptr
        rcv_buf_len : i32
        time : i64

        // receive content with 100 ms timeout
        success := eCAL.Sub_Receive_Buffer_Alloc(sub, &rcv_buf, &rcv_buf_len, &time, 100);
        if(success != 0)
        {
            // in_str := strings.string_from_ptr(cast(^u8)rcv_buf, cast(int)rcv_buf_len)
            // fmt.printf("Received topic \"Hello\" with \"%s\"\n", in_str);
            // in_buf := make([dynamic]u8, rcv_buf_len)
            // defer delete(in_buf)

            in_buf := make([]u8, rcv_buf_len)
            defer delete(in_buf)

            mem.copy(&in_buf[0], rcv_buf, int(rcv_buf_len))

            
            if message, ok := protobuf.decode(protos.Person, in_buf); ok {
                fmt.printf("Decoded message: %#v\n", message)
            } else {
                fmt.eprintf("Failed to decode message\n")
            }

            // free buffer allocated by eCAL
            eCAL.FreeMem(rcv_buf)
        }
    }

    // destroy subscriber
    eCAL.Sub_Destroy(sub)

    // finalize eCAL API
    eCAL.Finalize(eCAL.eCAL_Init_All)
}
