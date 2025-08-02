package hello_send;

import "core:fmt"
import "core:c"
import "core:strings"


import eCAL "../../../ecal"

main ::proc(){

    fmt.printf("-------------------------------\n");
    fmt.printf(" ODIN: HELLO WORLD SENDER\n");
    fmt.printf("-------------------------------\n");

    loop_count := 0

    fmt.printfln("eCAL %s (%s)", eCAL.GetVersionString(), eCAL.GetVersionDateString());

    eCAL.Initialize("hello send odin", nil, nil)

    eCAL.Process_SetState(eCAL.Process_eSeverity.healthy, eCAL.Process_eSeverityLevel._1, "I feel good!");

    data_type_information := eCAL.SDataTypeInformation{
        name="string",
        encoding="utf-8",
        descriptor=nil,
        descriptor_length=0
    }

    publisher := eCAL.Publisher_New("hello", &data_type_information, nil, nil)
    
    for {
        if eCAL.Ok() == 0 do break

        msg := fmt.aprintf("Hello from ODIN (%d)", loop_count)

        loop_count += 1

        message : cstring = strings.clone_to_cstring(msg, context.temp_allocator)
        message_len : uint = len(message)

        if eCAL.Publisher_Send(publisher, cast(rawptr)message, message_len, nil) == 0 {
            fmt.printfln("Sent string message in ODIN: \"%s\"", message)
        }
        else {
            fmt.printfln("Sending string message in ODIN failed!");
        }

        eCAL.Process_SleepMS(500);
    }

    // // finalize eCAL API
    eCAL.Finalize()

    defer free_all(context.temp_allocator)
}
