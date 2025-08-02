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
* @file   ecal_c/pubsub/publisher.h
* @brief  eCAL publisher c interface
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

Publisher :: struct {}

@(default_calling_convention="c", link_prefix="eCAL_")
foreign lib {
	/**
	* @brief Creates a new publisher instance
	*
	* @param topic_name_          Unique topic name.
	* @param data_type_info_      Topic data type information (encoding, type, descriptor). Optional, can be NULL.
	* @param pub_event_callback_  Publisher event callback funtion. Optional, can be NULL.
	* @param config_              Configuration parameter. Optional, can be NULL.
	*
	* @return Publisher handle is returned on success, otherwise NULL. The handle needs to be deleted by eCAL_Publisher_Delete().
	**/
	Publisher_New :: proc(topic_name_: cstring, data_type_information_: ^SDataTypeInformation, pub_event_callback: PubEventCallbackT, publisher_configuration_: ^Publisher_Configuration) -> ^Publisher ---

	/**
	* @brief Deletes a publisher instance
	*
	* @param publisher_          Publisher handle.
	**/
	Publisher_Delete :: proc(publisher_: ^Publisher) ---

	/**
	* @brief Send a message to all subscribers.
	*
	* @param publisher_          Publisher handle.
	* @param buffer_             Pointer to content buffer.
	* @param buffer_len_         Length ofthe buffer.
	* @param timestamp_          Send timestamp in microseconds. Optional, can be NULL.
	*
	* @return Zero if succeeded, non-zero otherwise.
	**/
	Publisher_Send :: proc(publisher_: ^Publisher, buffer_: rawptr, buffer_len_: c.size_t, timestamp_: ^c.longlong) -> c.int ---

	/**
	* @brief Send a message to all subscribers.
	*
	* @param publisher_         Publisher handle.
	* @param payload_writer_    Payload writer.
	* @param timestamp_         Send timestamp in microseconds. Optional, can be NULL.
	*
	* @return Zero if succeeded, non-zero otherwise.
	**/
	Publisher_SendPayloadWriter :: proc(publisher_: ^Publisher, payload_writer_: ^PayloadWriter, timestamp_: ^c.longlong) -> c.int ---

	/**
	* @brief Query the number of subscribers.
	*
	* @param publisher_ Publisher handle.
	*
	* @return Number of subscribers.
	**/
	Publisher_GetSubscriberCount :: proc(publisher_: ^Publisher) -> c.size_t ---

	/**
	* @brief Retrieve the topic name.
	*
	* @param publisher_  Publisher handle.
	*
	* @return The topic name.
	**/
	Publisher_GetTopicName :: proc(publisher_: ^Publisher) -> cstring ---

	/**
	* @brief Retrieve the topic id.
	*
	* @param publisher_  Publisher handle.
	*
	* @return The topic id.
	**/
	Publisher_GetTopicId :: proc(publisher_: ^Publisher) -> ^STopicId ---

	/**
	* @brief Gets description of the connected topic.
	*
	* @param publisher_  Publisher handle.
	*
	* @return The topic information.
	**/
	Publisher_GetDataTypeInformation :: proc(publisher_: ^Publisher) -> ^SDataTypeInformation ---
}
