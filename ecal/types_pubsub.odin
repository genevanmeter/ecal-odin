/* ========================= eCAL LICENSE =================================
*
* Copyright (C) 2016 - 2025 Continental Corporation
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*
* ========================= eCAL LICENSE =================================
*/
/**
* @file   pubsub/types.h
* @brief  eCAL subscriber callback c interface
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

/**
* @brief A struct which uniquely identifies anybody producing or consuming topics, e.g. a CPublisher or a CSubscriber.
**/
STopicId :: struct {
	topic_id:   SEntityId, //!< The unique id of the topic
	topic_name: cstring,   //!< The topics name (on which matching is performed in the pub/sub case)
}

/**
* @brief eCAL publisher event callback type.
**/
ePublisherEvent :: enum c.int {
	none,
	connected,    //!< a new subscriber has been connected to the publisher
	disconnected, //!< a previously connected subscriber has been disconnected from this publisher
	dropped,      //!< some subscriber has missed a message that was sent by this publisher
}

/**
* @brief eCAL publisher event callback struct.
**/
SPubEventCallbackData :: struct {
	event_type:          ePublisherEvent,      //!< publisher event type
	event_time:          c.longlong,           //!< publisher event time in us (eCAL time)
	subscriber_datatype: SDataTypeInformation, //!< datatype description of the connected subscriber
}

/**
* @brief Publisher event callback function type.
*
* @param topic_id_  The topic id struct of the received message.
* @param data_      Event callback data structure with the event specific information.
**/
PubEventCallbackT :: proc "c" (^STopicId, ^SPubEventCallbackData)

/**
* @brief eCAL subscriber event callback type.
**/
eSubscriberEvent :: enum c.int {
	none,
	connected,    //!< a new publisher has been connected to the subscriber
	disconnected, //!< a previously connected publisher has been disconnected from this subscriber
	dropped,      //!< a message coming from a publisher has been dropped, e.g. the subscriber has missed it
}

/**
* @brief eCAL publisher event callback struct.
**/
SSubEventCallbackData :: struct {
	event_type:         eSubscriberEvent,     //!< publisher event type
	event_time:         c.longlong,           //!< publisher event time in us (eCAL time)
	publisher_datatype: SDataTypeInformation, //!< datatype description of the connected subscriber
}

/**
* @brief Subscriber event callback function type.
*
* @param topic_id_  The topic id struct of the received message.
* @param data_      Event callback data structure with the event specific information.
**/
SubEventCallbackT :: proc "c" (^STopicId, ^SSubEventCallbackData)

/**
* @brief eCAL subscriber receive callback struct.
**/
SReceiveCallbackData :: struct {
	buffer:         rawptr,   //!< payload buffer, containing the sent data
	buffer_size:    c.size_t, //!< payload buffer size
	send_timestamp: i64,      //!< publisher send timestamp in us
	send_clock:     i64,      //!< publisher send clock. Each publisher increases the counter by one, every time a message is sent. It can be used to detect message drops.
}

/**
* @brief Receive callback function type. A user can register this callback type with a subscriber, and this callback will be triggered when the user receives any data.
*
* @param publisher_id_            The topic id of the publisher that has sent the data which is now being received.
* @param data_type_info_          Topic metadata, as set by the publisher (encoding, type, descriptor).
*                                 This can be used to validate that the received data can be properly interpreted by the subscriber.
* @param data_                    Data struct containing payload, timestamp and publication clock.
* @param user_argument_  User argument that was forwarded by a SetCallback() function.
**/
ReceiveCallbackT :: proc "c" (^STopicId, ^SDataTypeInformation, ^SReceiveCallbackData, rawptr)

