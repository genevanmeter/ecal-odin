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
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

/**
* @brief Unique ID with which to identify a service (client or server)
*        It can be queried from the client or the server, and it can be obtained from the registration layer.
**/
SServiceId :: struct {
	service_id:   SEntityId,
	service_name: cstring,
}

/**
* @brief eCAL service client event callback type.
**/
eClientEvent :: enum c.int {
	none,         //!< undefined
	connected,    //!< a new server has been connected to this client
	disconnected, //!< a server has been disconnected from this client
	timeout,      //!< a service call has timeouted 
}

/**
* @brief  Service call state. This enum class is being used when a client is calling a servers.
**/
eCallState :: enum c.int {
	none,      //!< undefined
	executed,  //!< the service call was executed successfully
	timeouted, //!< the service call has timeouted
	failed,    //!< failed
}

/**
* @brief eCAL client event callback struct.
**/
SClientEventCallbackData :: struct {
	type: eClientEvent, //!< event type
	time: c.longlong,   //!< event time in us
}

/**
* @brief Client event callback function type.
*
* @param service_id_  The service id struct of the connection that triggered the event.
* @param data_        Event callback data structure with the event specific information.
**/
ClientEventCallbackT :: proc "c" (^SServiceId, ^SClientEventCallbackData)

/**
* @brief eCAL service server event callback type.
**/
eServerEvent :: enum c.int {
	none,         //!< undefined
	connected,    //!< a new client has been connected to this server
	disconnected, //!< a client has been disconnected from this server
}

/**
* @brief eCAL client event callback struct.
**/
SServerEventCallbackData :: struct {
	type: eServerEvent, //!< event type
	time: c.longlong,   //!< event time in us
}

/**
* @brief Server event callback function type.
*
* @param service_id_  The service id struct of the connection that triggered the event.
* @param data_        Event callback data structure with the event specific information.
**/
ServerEventCallbackT :: proc "c" (^SServiceId, ^SServerEventCallbackData)

/**
* @brief Service method information struct containing the method name, the request and response type information.
*        This type is used when creating services (servers or clients), or when querying information about them from the registration layer.
**/
SServiceMethodInformation :: struct {
	method_name:   cstring,              //!< The name of the method.
	request_type:  SDataTypeInformation, //!< The type of the method request.
	response_type: SDataTypeInformation, //!< The type of the method response.
}

/**
* @brief Service response struct containing the (responding) server information and the response itself.
**/
SServiceResponse :: struct {
	call_state:                 eCallState,                //!< call state, to indicate if the call was successful or not
	server_id:                  SServiceId,                //!< Id of the server that executed the service (server id (entity id, process id, host name), name)
	service_method_information: SServiceMethodInformation, //!< Additional Information about the method that has been called (name & DatatypeInformation of request and reponse)
	ret_state:                  c.int,                     //!< return state of the called service method 
	response:                   rawptr,                    //!< the actual response data of the service call
	response_length:            c.size_t,                  //!< length of response data
	error_msg:                  cstring,                   //!< human readable error message, in case that the service call could not be executed.
}

/**
* @brief Service response callback function type (low level client interface).
*
* @param service_response_  Service response struct containing the (responding) server informations and the response itself.
* @param user_argument_     User argument that was forwarded by a SetCallback() function.
**/
ResponseCallbackT :: proc "c" (^SServiceResponse, rawptr)

/**
* @brief Service method callback function type (low level server interface).
*        This is the type definition of a function that can be registered for a CServiceServer.
*        It callback is then called, a client
*
* @param      method_info       The method information struct containing the request and response type information.
* @param      request_          The request.
* @param      request_length    Length of request
* @param[out] response_         Response data which needs to be set and allocated by eCAL_Malloc() from user space.
* @param[out] response_length_  Length of response data set from the user space.
* @param      user_argument_    User argument that was forwarded by a SetCallback() function.
**/
ServiceMethodCallbackT :: proc "c" (^SServiceMethodInformation, rawptr, c.size_t, ^rawptr, ^c.size_t, rawptr) -> c.int

