package minimal_pub;

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

    eCAL.Initialize(cast(c.int)argc, cast(^cstring)(&argv[0]), "minimal_pub", eCAL.eCAL_Init_Default)

    pub := eCAL.Pub_New()
    
    eCAL.Pub_Create(pub, "Hello", "base:std::string", "", 0)

    count := 0

    for {
        if eCAL.Ok() == 0 do break

        count += 1

        msg := fmt.aprintf("Hello from ODIN %d", count)

        out_str : cstring = strings.clone_to_cstring(msg)
        out_len : c.int = c.int(len(out_str))

        fmt.printfln("Topic \"%s\" Publishing \"%s\"\n", "Hello", out_str)

        eCAL.Pub_Send(pub, cast(rawptr)out_str, out_len, -1)

        // sleep 100 ms
        eCAL.Process_SleepMS(100);
    }

    // finalize eCAL API
    eCAL.Finalize(eCAL.eCAL_Init_All)
}
