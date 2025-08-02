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
* @file   ecal_c/pubsub/subscriber.h
* @brief  eCAL subscriber c interface
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

Subscriber :: struct {}

@(default_calling_convention="c", link_prefix="eCAL_")
foreign lib {
	/**
	* @brief Creates a new subscriber instance.
	*
	* @param topic_name_      Unique topic name.
	* @param data_type_info_  Topic data type information (encoding, type, descriptor). Optional, can be NULL.
	* @param event_callback_  Callback for subscriber events. Optional, can be NULL.
	* @param config_          Configuration parameter. Optional, can be NULL.
	*
	* @return Subscriber handle if succeeded, otherwise NULL. The handle needs to be deleted by eCAL_Subscriber_Delete().
	**/
	Subscriber_New :: proc(topic_name_: cstring, data_type_information_: ^SDataTypeInformation, sub_event_callback: SubEventCallbackT, subscriber_configuration_: ^Subscriber_Configuration) -> ^Subscriber ---

	/**
	* @brief Deletes a subscriber instance
	*
	* @param subscriber_  Subscriber handle.
	**/
	Subscriber_Delete :: proc(subscriber_: ^Subscriber) ---

	/**
	* @brief Set/overwrite callback function for incoming receives.
	*
	* @param subscriber_      Subscriber handle.
	* @param callback_        The callback function to set.
	* @param user_argument_   User argument that is forwarded to the callback. Optional, can be NULL.
	**/
	Subscriber_SetReceiveCallback :: proc(subscriber_: ^Subscriber, callback_: ReceiveCallbackT, callback_user_argument_: rawptr) ---

	/**
	* @brief Remove callback function for incoming receives.
	*
	* @param subscriber_  Subscriber handle.
	**/
	Subscriber_RemoveReceiveCallback :: proc(subscriber_: ^Subscriber) ---

	/**
	* @brief Query the number of connected publishers.
	*
	* @param subscriber_  Subscriber handle.
	*
	* @return Number of publishers.
	**/
	Subscriber_GetPublisherCount :: proc(subscriber_: ^Subscriber) -> c.size_t ---

	/**
	* @brief Retrieve the topic name.
	*
	* @param subscriber_  Subscriber handle.
	*
	* @return  The topic name.
	**/
	Subscriber_GetTopicName :: proc(subscriber_: ^Subscriber) -> cstring ---

	/**
	* @brief Retrieve the topic id.
	*
	* @param subscriber_  Subscriber handle.
	*
	* @return  The topic id.
	**/
	Subscriber_GetTopicId :: proc(subscriber_: ^Subscriber) -> ^STopicId ---

	/**
	* @brief Retrieve the topic information.
	*
	* @param subscriber_  Subscriber handle.
	*
	* @return  The topic information.
	**/
	Subscriber_GetDataTypeInformation :: proc(subscriber_: ^Subscriber) -> ^SDataTypeInformation ---
}
