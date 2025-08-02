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
* @file   ecal_c/service/client_instance.h
* @brief  eCAL client instance c interface
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

ClientInstance :: struct {}

@(default_calling_convention="c", link_prefix="eCAL_")
foreign lib {
	/**
	* @brief Deletes an array of client instances
	*
	* @param client_instances_  Client instance handles.
	**/
	ClientInstances_Delete :: proc(client_instances_: ^^ClientInstance) ---

	/**
	* @brief Blocking call of a service method for one service instances. Response will be returned as struct eCAL_SServiceResponse.
	*
	* @param       client_instance_  Client instance handle.
	* @param       method_name_      Method name.
	* @param       request_          Request data.
	* @param       request_length_   Length of requested data.
	* @param       timeout_ms_       Maximum time before operation returns. Optional, can be NULL.
	*
	* @return Pointer to service response if succeeded, NULL otherwise. Needs to be released by eCAL_Free().
	**/
	ClientInstance_CallWithResponse :: proc(client_instance_: ^ClientInstance, method_name_: cstring, request_: rawptr, request_length_: c.size_t, timeout_ms_: ^c.int) -> ^SServiceResponse ---

	/**
	* @brief Blocking call (with timeout) of a service method for on service instances, using callback
	*
	* @param client_instance_         Client instance handle.
	* @param method_name_             Method name.
	* @param request_                 Request data.
	* @param request_length_          Length of requested data.
	* @param callback_                Callback function for the service method response.
	* @param callback_user_argument_  User argument that is forwarded to the callback. Optional, can be NULL.
	* @param timeout_ms_              Maximum time before operation returns. Optional, can be NULL.
	*
	* @return Zero if succeeded, non-zero otherwise.
	**/
	ClientInstance_CallWithCallback :: proc(client_instance_: ^ClientInstance, method_name_: cstring, request_: rawptr, request_length_: c.size_t, callback_: ResponseCallbackT, callback_user_argument_: rawptr, timeout_ms_: ^c.int) -> c.int ---

	/**
	* @brief Asynchronous call of a service method for one service instances, using callback
	*
	* @param client_instance_         Client instance handle.
	* @param method_name_             Method name.
	* @param request_                 Request data.
	* @param request_length_          Length of requested data.
	* @param callback_                Callback function for the service method response.
	* @param callback_user_argument_  User argument that is forwarded to the callback. Optional, can be NULL.
	*
	* @return Zero if succeeded, non-zero otherwise.
	**/
	ClientInstance_CallWithCallbackAsync :: proc(client_instance_: ^ClientInstance, method_name_: cstring, request_: rawptr, request_length_: c.size_t, callback_: ResponseCallbackT, callback_user_argument_: rawptr) -> c.int ---

	/**
	* @brief Check connection state.
	*
	* @param client_instance_  Client instance handle.
	*
	* @return Non-zero if connected, zero otherwise.
	**/
	ClientInstance_IsConnected :: proc(client_instance_: ^ClientInstance) -> c.int ---

	/**
	* @brief Get unique client entity id.
	*
	* @param client_instance_  Client instance handle.
	*
	* @return  The client entity id.
	**/
	ClientInstance_GetClientID :: proc(client_instance_: ^ClientInstance) -> ^SEntityId ---
}
