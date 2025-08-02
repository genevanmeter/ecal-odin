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
* @file   ecal_c/service/server.h
* @brief  eCAL service c interface
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

ServiceServer :: struct {}

@(default_calling_convention="c", link_prefix="eCAL_")
foreign lib {
	/**
	* @brief Creates a new server instance
	*
	* @param service_name_   Unique service name.
	* @param event_callback_ Callback function for server events. Optional, can be NULL.
	*
	* @return Server handle if succeeded, NULL otherwise. The handle needs to be released by eCAL_ServiceServer_Delete().
	**/
	ServiceServer_New :: proc(service_name_: cstring, event_callback_: ServerEventCallbackT) -> ^ServiceServer ---

	/**
	* @brief Deletes a server instance
	*
	* @param service_server_  Server handle.
	**/
	ServiceServer_Delete :: proc(service_server_: ^ServiceServer) ---

	/**
	* @brief Set/overwrite a method callback, that will be invoked, when a connected client is making a service call.
	*
	* @param service_server_         Server handle.
	* @param method_info_            Service method information (method name, request & response types).
	* @param callback_               Callback function for client request.
	* @param callback_user_argument_ User argument that is forwarded to the callback. Optional, can be NULL.
	*
	* @return Zero if succeeded, non-zero otherwise.
	**/
	ServiceServer_SetMethodCallback :: proc(service_server_: ^ServiceServer, method_info_: ^SServiceMethodInformation, callback_: ServiceMethodCallbackT, callback_user_argument_: rawptr) -> c.int ---

	/**
	* @brief Remove method callback.
	*
	* @param service_server_  Server handle.
	* @param method_          Service method name.
	*
	* @return Zero if succeeded, non-zero otherwise.
	**/
	ServiceServer_RemoveMethodCallback :: proc(service_server_: ^ServiceServer, method_name_: cstring) -> c.int ---

	/**
	* @brief Retrieve service name.
	*
	* @param service_server_  Server handle.
	*
	* @return The service name.
	**/
	ServiceServer_GetServiceName :: proc(service_server_: ^ServiceServer) -> cstring ---

	/**
	* @brief Retrieve the service id.
	*
	* @param service_server_  Server handle.
	*
	* @return The service id.
	**/
	ServiceServer_GetServiceId :: proc(service_server_: ^ServiceServer) -> ^SServiceId ---

	/**
	* @brief Check connection state.
	*
	* @param service_server_  Server handle.
	*
	* @return Non-zero if connected, zero otherwise.
	**/
	ServiceServer_IsConnected :: proc(service_server_: ^ServiceServer) -> c.int ---
}
