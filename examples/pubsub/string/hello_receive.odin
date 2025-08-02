package hello_receive;

import "core:fmt"
import "core:c"
import "core:strings"
import "base:runtime"

import eCAL "../../../ecal"

custom_context: runtime.Context

OnReceive :: proc "c" (topic_id_: ^eCAL.STopicId, data_type_information_ : ^eCAL.SDataTypeInformation, callback_data_ : ^eCAL.SReceiveCallbackData, user_argument_ : rawptr)
{
    context = runtime.default_context()

    in_str := strings.string_from_ptr(cast(^u8)callback_data_.buffer, cast(int)callback_data_.buffer_size)

    fmt.printf("---------------------------------------------------\n")
    fmt.printf(" Received string message from topic \"%s\" in Odin\n", topic_id_.topic_name)
    fmt.printf("---------------------------------------------------\n")
    fmt.printf(" Size    : %d\n",  callback_data_.buffer_size)
    fmt.printf(" Time    : %d\n",  callback_data_.send_timestamp)
    fmt.printf(" Clock   : %d\n",  callback_data_.send_clock)
    fmt.printf(" Message : %s\n",  in_str)
    fmt.printf("\n")
}


main :: proc() {
    fmt.printf("-------------------------------\n");
    fmt.printf(" ODIN: HELLO WORLD RECEIVER\n");
    fmt.printf("-------------------------------\n");

    eCAL.Initialize("hello receiver odin", nil, nil)

    fmt.printfln("eCAL %s (%s)", eCAL.GetVersionString(), eCAL.GetVersionDateString());

    eCAL.Process_SetState(eCAL.Process_eSeverity.healthy, eCAL.Process_eSeverityLevel._1, "I feel good!");

    data_type_information := eCAL.SDataTypeInformation{
        name="string",
        encoding="utf-8",
        descriptor=nil,
        descriptor_length=0
    }

    subscriber := eCAL.Subscriber_New("hello", &data_type_information, nil, nil)

    eCAL.Subscriber_SetReceiveCallback(subscriber, OnReceive, nil);

    for {
        if eCAL.Ok() == 0 do break

        eCAL.Process_SleepMS(500);
    }

    // destroy subscriber
    eCAL.Subscriber_Delete(subscriber)

    // finalize eCAL API
    eCAL.Finalize()
}
