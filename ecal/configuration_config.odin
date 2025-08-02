/* =========================== LICENSE =================================
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
* =========================== LICENSE =================================
*/
/**
* @file   config/configuration.h
* @brief  eCAL configuration c interface
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

eCommunicationMode :: enum c.int {
	local,
	network,
}

Configuration_Impl :: struct {}

Configuration :: struct {
	transport_layer:    TransportLayer_Configuration,
	registration:       Registration_Configuration,
	subscriber:         Subscriber_Configuration,
	publisher:          Publisher_Configuration,
	timesync:           Time_Configuration,
	application:        Application_Configuration,
	logging:            Logging_Configuration,
	communication_mode: eCommunicationMode, /*!< eCAL components communication mode:
                                                       local: local host only communication (default)
                                                       cloud: communication across network boundaries */
	_impl:              ^Configuration_Impl,
}

@(default_calling_convention="c", link_prefix="eCAL_")
foreign lib {
	Configuration_New                      :: proc() -> ^Configuration ---
	Configuration_Delete                   :: proc(configuration_: ^Configuration) ---
	Configuration_InitFromConfig           :: proc(configuration_: ^Configuration) ---
	Configuration_InitFromFile             :: proc(configuration_: ^Configuration, yaml_path_: cstring) ---
	Configuration_GetConfigurationFilePath :: proc(configuration_: ^Configuration) -> cstring ---
}
