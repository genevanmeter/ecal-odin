package hello_send;

import "core:fmt"
import "core:c"
import "core:strings"


import eCAL "../../../ecal"

main ::proc(){
    version_str := eCAL.GetVersionString()
    version_date_str := eCAL.GetVersionDateString()

    fmt.printfln("eCAL Version: %s\nBuild Date: %s\n",version_str, version_date_str)

    eCAL.Initialize("hello send c", nil, nil)

    data_type_information := eCAL.SDataTypeInformation{
        name="string",
        encoding="utf-8",
        descriptor=nil,
        descriptor_length=0
    }

    topic : cstring = "hello"

    publisher := eCAL.Publisher_New(topic, &data_type_information, nil, nil)

    count := 0

    for {
        if eCAL.Ok() == 0 do break

        count += 1

        msg := fmt.aprintf("Hello from ODIN %d", count)

        out_str : cstring = strings.clone_to_cstring(msg, context.temp_allocator)
        out_len : uint = len(out_str)

        fmt.printfln("Topic \"%s\" Publishing \"%s\"", topic, out_str)

        eCAL.Publisher_Send(publisher, cast(rawptr)out_str, out_len, nil)

        // sleep 100 ms
        eCAL.Process_SleepMS(100);
    }

    // // finalize eCAL API
    eCAL.Finalize()

    defer free_all(context.temp_allocator)
}
