
package minimal_sub_cb;

import "core:fmt"
import "core:c"
import "core:strings"
import "core:os"
import "base:runtime"

import eCAL "../../../ecal"

custom_context: runtime.Context

OnReceive :: proc "c" (topic_name_ : cstring, data_ : ^eCAL.SReceiveCallbackDataC, par_ : rawptr)
{
    context = custom_context

    fmt.printf("Received topic \"%s\" with ", topic_name_);

    in_str := strings.string_from_ptr(cast(^u8)data_.buf, cast(int)data_.size)
    defer delete(in_str)

    fmt.printf("\"%s\"\n", in_str)
}

main :: proc() {
    
    args := os.args

    argc := len(args)
    argv := make([dynamic]cstring, argc)
    defer delete(argv)

    for i in 0 ..< argc {
		argv[i] = strings.unsafe_string_to_cstring(args[i])
	}

    version_str := eCAL.GetVersionString()
    version_date_str := eCAL.GetVersionDateString()

    fmt.printfln("eCAL Version: %s\nBuild Date: %s\n",version_str, version_date_str)

    eCAL.Initialize(cast(c.int)argc, cast(^cstring)(&argv[0]), "minimal_sub", eCAL.Init_Default)

    sub := eCAL.Sub_New()
    
    eCAL.Sub_Create(sub, "Hello", "base:std::string", "", 0);

    eCAL.Sub_AddReceiveCallback(sub, OnReceive, nil);

    for {
        if eCAL.Ok() == 0 do break

        // sleep 100 ms
        eCAL.Process_SleepMS(100);
    }

    // destroy subscriber
    eCAL.Sub_Destroy(sub)

    // finalize eCAL API
    eCAL.Finalize(eCAL.Init_All)
}
