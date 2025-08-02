package hello_receive;

import "core:fmt"
import "core:c"
import "core:strings"
import "base:runtime"

import eCAL "../../../ecal"

custom_context: runtime.Context

//void OnReceive(const struct eCAL_STopicId* topic_id_, const struct eCAL_SDataTypeInformation* data_type_information_, const struct eCAL_SReceiveCallbackData* callback_data_, void* user_argument_)

OnReceive :: proc "c" (topic_id_: ^eCAL.STopicId, data_type_information_ : ^eCAL.SDataTypeInformation, callback_data_ : ^eCAL.SReceiveCallbackData, user_argument_ : rawptr)
{
    context = runtime.default_context()

    in_str := strings.string_from_ptr(cast(^u8)callback_data_.buffer, cast(int)callback_data_.buffer_size)

    fmt.printfln("Received topic \"%s\" with %s ", topic_id_.topic_name, in_str );

}


main :: proc() {
    version_str := eCAL.GetVersionString()
    version_date_str := eCAL.GetVersionDateString()

    fmt.printfln("eCAL Version: %s\nBuild Date: %s\n",version_str, version_date_str)

    eCAL.Initialize("hello receiver c", nil, nil)

    data_type_information := eCAL.SDataTypeInformation{
        name="string",
        encoding="utf-8",
        descriptor=nil,
        descriptor_length=0
    }

    topic : cstring = "hello"

    subscriber := eCAL.Subscriber_New(topic, &data_type_information, nil, nil)


    eCAL.Subscriber_SetReceiveCallback(subscriber, OnReceive, nil);

    for {
        if eCAL.Ok() == 0 do break

        // sleep 100 ms
        eCAL.Process_SleepMS(100);
    }

    // destroy subscriber
    eCAL.Subscriber_Delete(subscriber)

    // finalize eCAL API
    eCAL.Finalize()
}
