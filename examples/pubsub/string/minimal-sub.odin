
package minimal_sub;

import "core:fmt"
import "core:c"
import "core:strings"
import "core:os"

import eCAL "../../../ecal"

main :: proc() {
    
    args := os.args
	defer delete(args)

	argc := len(args)
    argv := make([dynamic]cstring, argc)
    defer delete(argv)

    for i in 0 ..< argc {
		argv[i] = strings.unsafe_string_to_cstring(args[i])
	}

    version_str := eCAL.GetVersionString()
    version_date_str := eCAL.GetVersionDateString()

    fmt.printfln("eCAL Version: %s\nBuild Date: %s\n",version_str, version_date_str)

    eCAL.Initialize(cast(c.int)argc, cast(^cstring)(&argv[0]), "minimal_sub", eCAL.eCAL_Init_Default)

    sub := eCAL.Sub_New()
    
    eCAL.Sub_Create(sub, "Hello", "base:std::string", "", 0);

    for {
        if eCAL.Ok() == 0 do break

        rcv_buf : rawptr
        rcv_buf_len : i32
        time : i64

        // receive content with 100 ms timeout
        success := eCAL.Sub_Receive_Buffer_Alloc(sub, &rcv_buf, &rcv_buf_len, &time, 100);
        if(success != 0)
        {
            in_str := strings.string_from_ptr(cast(^u8)rcv_buf, cast(int)rcv_buf_len)
            fmt.printf("Received topic \"Hello\" with \"%s\"\n", in_str);

            // free buffer allocated by eCAL
            eCAL.FreeMem(rcv_buf)
        }
    }

    // destroy subscriber
    eCAL.Sub_Destroy(sub)

    // finalize eCAL API
    eCAL.Finalize(eCAL.eCAL_Init_All)
}
