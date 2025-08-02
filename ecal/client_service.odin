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
* @file   ecal_c/service/client.h
* @brief  eCAL client c interface
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

ServiceClient :: struct {}

@(default_calling_convention="c", link_prefix="eCAL_")
foreign lib {
	/**
	* @brief Creates a new client instance
	*
	* @param service_name_                  Unique service name.
	* @param method_information_set_        Set of method names and corresponding datatype information as array. Optional, can be NULL.
	* @param method_information_set_length_ Length of the method information set. Optional, can be 0.
	* @param event_callback_                The client event callback funtion. Optional, can be NULL.
	*
	* @return Client handle if succeeded, otherwise NULL. The handle needs to be released by eCAL_ServiceClient_Delete().
	**/
	ServiceClient_New :: proc(service_name_: cstring, method_information_set_: ^SServiceMethodInformation, method_information_set_length_: c.size_t, event_callback_: ClientEventCallbackT) -> ^ServiceClient ---

	/**
	* @brief Deletes a client instance
	*
	* @param service_client_  Client handle.
	**/
	ServiceClient_Delete :: proc(service_client_: ^ServiceClient) ---

	/**
	* @brief Get the client instances for all matching services
	*
	* @param service_client_  Client handle.
	*
	* @return Pointer array of client instance handles if succeeded, NULL otherwise. The handles are stored in a null pointer terminated array and have to be deleted by eCAL_ClientInstances_Delete().
	**/
	ServiceClient_GetClientInstances :: proc(service_client_: ^ServiceClient) -> ^^ClientInstance ---

	/**
	* @brief Blocking call of a service method for all existing service instances, response will be returned as an array of struct eCAL_SServiceResponse
	*
	* @param       service_client_               Client handle.
	* @param       method_name_                  Method name.
	* @param       request_                      Request data.
	* @param       request_length_               Length of requested data.
	* @param [out] service_response_vec_         Returned array of service responses from every called service. Must point to NULL and needs to be released by eCAL_Free().
	* @param [out] service_response_vec_length_  Returned length of response array. Must point to zero.
	* @param       timeout_ms_                   Maximum time before operation returns. Optional, can be NULL.
	*
	* @return Zero if all calls were successful and minimum one instance was connected, non-zero otherwise.
	**/
	ServiceClient_CallWithResponse :: proc(service_client_: ^ServiceClient, method_name_: cstring, request_: rawptr, request_length_: c.size_t, service_response_vec_: ^^SServiceResponse, service_response_vec_length_: ^c.size_t, timeout_ms_: ^c.int) -> c.int ---

	/**
	* @brief Blocking call (with timeout) of a service method for all existing service instances, using callback
	*
	* @param service_client_          Client handle.
	* @param method_name_             Method name.
	* @param request_                 Request data.
	* @param request_length_          Length of requested data.
	* @param callback_                Callback function for the service method response.
	* @param callback_user_argument_  User argument that is forwarded to the callback. Optional, can be NULL.
	* @param timeout_ms_              Maximum time before operation returns. Optional, can be NULL.
	*
	* @return Zero if all calls were successful and minimum one instance was connected, non-zero otherwise.
	**/
	ServiceClient_CallWithCallback :: proc(service_client_: ^ServiceClient, method_name_: cstring, request_: rawptr, request_length_: c.size_t, callback_: ResponseCallbackT, callback_user_argument_: rawptr, timeout_ms_: ^c.int) -> c.int ---

	/**
	* @brief Asynchronous call of a service method for all existing service instances, using callback
	*
	* @param service_client_          Client handle.
	* @param method_name_             Method name.
	* @param request_                 Request data.
	* @param request_length_          Length of requested data.
	* @param callback_                Callback function for the service method response.
	* @param callback_user_argument_  User argument that is forwarded to the callback. Optional, can be NULL.
	*
	* @return Zero if all calls were successful and minimum one instance was connected, non-zero otherwise.
	**/
	ServiceClient_CallWithCallbackAsync :: proc(service_client_: ^ServiceClient, method_name_: cstring, request_: rawptr, request_length_: c.size_t, callback_: ResponseCallbackT, callback_user_argument_: rawptr) -> c.int ---

	/**
	* @brief Retrieve service name.
	*
	* @param service_client_  Client handle.
	*
	* @return The service name.
	**/
	ServiceClient_GetServiceName :: proc(service_client_: ^ServiceClient) -> cstring ---

	/**
	* @brief Retrieve the service id.
	*
	* @param service_client_  Client handle.
	*
	* @return The service id.
	**/
	ServiceClient_GetServiceId :: proc(service_client_: ^ServiceClient) -> ^SServiceId ---

	/**
	* @brief Check connection to at least one service.
	*
	* @param service_client_  Client handle.
	*
	* @return Non-zero if at least one service client instance is connected, zero otherwise.
	**/
	ServiceClient_IsConnected :: proc(service_client_: ^ServiceClient) -> c.int ---
}
