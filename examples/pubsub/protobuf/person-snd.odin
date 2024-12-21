package person_snd

import "core:os"
import "core:fmt"
import "core:c"
import "core:strings"

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

    eCAL.Initialize(cast(c.int)argc, cast(^cstring)(&argv[0]), "person publisher", eCAL.eCAL_Init_Default)

    pub := eCAL.Pub_New()
    
    eCAL.Pub_Create(pub, "person", "proto", "", 0)


    count := 0

    for {
        if eCAL.Ok() == 0 do break

        count += 1

        message := protos.Person {
            id = i32(count),
            name = "Max",
            stype = protos.Person_SType.MALE,
            email = "max@mail.net",
            dog = protos.Dog {
                name = "Brandy",
            },
            house = protos.House {
                rooms = 4,
            },
        }

        if encoded_buffer, encode_ok := protobuf.encode(message); encode_ok {
            fmt.printf("Encoded message: %x\nEncode Length: %d\n", encoded_buffer, len(encoded_buffer))
            msg_len := i32(len(encoded_buffer))
            eCAL.Pub_Send(pub, cast(rawptr)&encoded_buffer[0], msg_len, -1)
            if test_msg, ok := protobuf.decode(protos.Person, encoded_buffer); ok {
			fmt.printf("Decoded message: %#v\n", test_msg)
            } else {
                fmt.eprintf("Failed to decode message\n")
            }
        }
        else {
            fmt.eprintf("Failed to encode message\n")
        }
       
        // sleep 1000 ms
        eCAL.Process_SleepMS(1000);
    }

    // finalize eCAL API
    eCAL.Finalize(eCAL.eCAL_Init_All)

    defer free_all(context.temp_allocator)
}
