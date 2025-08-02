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
* @file   registration.h
* @brief  eCAL registration c interface
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

Registration_SServiceMethod :: struct {
	service_name: cstring,
	method_name:  cstring,
}

Registration_CallbackToken :: struct {}

Registration_RegistrationEventType :: enum c.int {
	new_entity,     //!< Represents a new entity registration
	deleted_entity, //!< Represents a deletion of an entity
}

Registration_TopicEventCallbackT :: proc "c" (^STopicId, Registration_RegistrationEventType)

@(default_calling_convention="c", link_prefix="eCAL_")
foreign lib {
	/**
	* @brief Get complete snapshot of all known publishers.
	*
	* @param[out] topic_ids_        Returned array of topics ids. Must point to NULL and needs to be released by eCAL_Free().
	* @param[out] topic_ids_length_ Returned length of the array. Must point to zero.
	*
	* @return Zero if succeeded, non-zero otherwise
	**/
	Registration_GetPublisherIDs :: proc(topic_ids_: ^^STopicId, topic_ids_length_: ^c.size_t) -> c.int ---

	/**
	* @brief Get data type information with quality for specific publisher.
	*
	* @param topic_id_        Publisher topic id.
	* @param[out] topic_info_ Returned data type information. Must point to NULL and needs to be released by eCAL_Free().
	*
	* @return Zero if succeeded, non-zero otherwise
	**/
	Registration_GetPublisherInfo :: proc(topic_id_: ^STopicId, topic_info_: ^^SDataTypeInformation) -> c.int ---

	/**
	* @brief Get complete snapshot of all known subscribers.
	*
	* @param[out] topic_ids_        Returned array of topic ids. Must point to NULL and needs to be released by eCAL_Free().
	* @param[out] topic_ids_length_ Returned length of the array. Must point to zero.
	*
	* @return Zero if succeeded, non-zero otherwise
	**/
	Registration_GetSubscriberIDs :: proc(topic_ids_: ^^STopicId, topic_ids_length_: ^c.size_t) -> c.int ---

	/**
	* @brief Get data type information with quality for specific subscriber.
	*
	* @param topic_id_        Topic id.
	* @param[out] topic_info_ Returned data type information. Must point to NULL and needs to be released by eCAL_Free().
	*
	* @return Zero if succeeded, non-zero otherwise
	**/
	Registration_GetSubscriberInfo :: proc(topic_id_: ^STopicId, topic_info_: ^^SDataTypeInformation) -> c.int ---

	/**
	* @brief Get complete snapshot of all known servers.
	*
	* @param[out] service_ids_      Returned array of service ids. Must point to NULL and needs to be released by eCAL_Free().
	* @param[out] topic_ids_length_ Returned length of the array. Must point to zero.
	*
	* @return Zero if succeeded, non-zero otherwise
	**/
	Registration_GetServerIDs :: proc(service_ids_: ^^SServiceId, service_ids_length_: ^c.size_t) -> c.int ---

	/**
	* @brief Get service method information with quality for specific server.
	*
	* @param service_id_                       Service id.
	* @param[out] service_method_info_         Returned array of service method information. Must point to NULL and needs to be released by eCAL_Free().
	* @param[out] service_method_info_length_  Returned length of the array. Must point to zero.
	*
	* @return Zero if succeeded, non-zero otherwise
	**/
	Registration_GetServerInfo :: proc(service_id_: ^SServiceId, service_method_info_: ^^SServiceMethodInformation, service_method_info_length_: ^c.size_t) -> c.int ---

	/**
	* @brief Get complete snapshot of all known clients.
	*
	* @param[out] service_ids_      Returned array of service ids. Must point to NULL and needs to be released by eCAL_Free().
	* @param[out] topic_ids_length_ Returned length of the array. Must point to zero.
	*
	* @return Zero if succeeded, non-zero otherwise
	**/
	Registration_GetClientIDs :: proc(service_ids_: ^^SServiceId, service_ids_length_: ^c.size_t) -> c.int ---

	/**
	* @brief Get service method information with quality for specific client.
	*
	* @param service_id_                       Service id.
	* @param[out] service_method_info_         Returned array of service method information. Must point to NULL and needs to be released by eCAL_Free().
	* @param[out] service_method_info_length_  Returned length of the array. Must point to zero.
	*
	* @return Zero if succeeded, non-zero otherwise
	**/
	Registration_GetClientInfo :: proc(service_id_: ^SServiceId, service_method_info_: ^^SServiceMethodInformation, service_method_info_length_: ^c.size_t) -> c.int ---

	/**
	* @brief Get all names of topics that are being published.
	*        This is a convenience function.
	*        It calls GetPublisherIDs() and filters by name
	*
	* @param[out] topic_names_         Returned pointer array of null-terminated strings. Must point to NULL and needs to be released by eCAL_Free().
	* @param[out] topic_names_length_  Returned length of the array. Must point to zero.
	*
	* @return Zero if succeeded, non-zero otherwise
	**/
	Registration_GetPublishedTopicNames :: proc(topic_names_: ^^^c.char, topic_names_length_: ^c.size_t) -> c.int ---

	/**
	* @brief Get all names of topics that are being subscribed.
	*        This is a convenience function.
	*        It calls GetSubscriberIDs() and filters by name
	*
	* @param[out] topic_names_         Returned pointer array of null-terminated strings. Must point to NULL and needs to be released by eCAL_Free().
	* @param[out] topic_names_length_  Returned length of the array. Must point to zero.
	*
	* @return Zero if succeeded, non-zero otherwise
	**/
	Registration_GetSubscribedTopicNames :: proc(topic_names_: ^^^c.char, topic_names_length_: ^c.size_t) -> c.int ---

	/**
	* @brief Get the pairs of service name / method name of all eCAL Servers.
	*
	* @param[out] server_method_names_        Returned array of server method names. Must point to NULL and needs to be released by eCAL_Free().
	* @param[out] server_method_names_length_ Returned length of the array. Must point to zero.
	*
	* @return Zero if succeeded, non-zero otherwise
	**/
	Registration_GetServerMethodNames :: proc(server_method_names_: ^^Registration_SServiceMethod, server_method_names_length_: ^c.size_t) -> c.int ---

	/**
	* @brief Get the pairs of service name / method name of all eCAL Clients.
	*
	* @param[out] client_method_names_        Returned array of client method names. Must point to NULL and needs to be released by eCAL_Free().
	* @param[out] client_method_names_length_ Returned length of the array. Must point to zero.
	*
	* @return Zero if succeeded, non-zero otherwise
	**/
	Registration_GetClientMethodNames :: proc(client_method_names_: ^^Registration_SServiceMethod, client_method_names_length_: ^c.size_t) -> c.int ---

	/**
	* @brief Register a callback function to be notified when a new publisher becomes available.
	*
	* @param callback_       The callback function to be called with the STopicId of the new publisher.
	*                        The callback function must not be blocked for a longer period of time,
	*                        otherwise timeout mechanisms of the eCAL registration would be triggered.
	*
	* @return CallbackToken that can be used to unregister the callback.
	**/
	Registration_AddPublisherEventCallback :: proc(callback_: Registration_TopicEventCallbackT) -> Registration_CallbackToken ---

	/**
	* @brief Unregister the publisher callback using the provided token.
	*
	* @param token_  The token returned by eCAL_Registration_AddPublisherEventCallback().
	**/
	Registration_RemPublisherEventCallback :: proc(token_: Registration_CallbackToken) ---

	/**
	* @brief Register a callback function to be notified when a new subscriber becomes available.
	*
	* @param callback_       The callback function to be called with the STopicId of the new subscriber.
	*                        The callback function must not be blocked for a longer period of time,
	*                        otherwise timeout mechanisms of the eCAL registration would be triggered.
	*
	* @return CallbackToken that can be used to unregister the callback.
	**/
	Registration_AddSubscriberEventCallback :: proc(callback_: Registration_TopicEventCallbackT) -> Registration_CallbackToken ---

	/**
	* @brief Unregister the subscriber callback using the provided token.
	*
	* @param token  The token returned by eCAL_Registration_AddSubscriberEventCallback().
	**/
	Registration_RemSubscriberEventCallback :: proc(token_: Registration_CallbackToken) ---
}
