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
* @file   config/logging.h
* @brief  eCAL configuration for logging
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

Logging_Provider_Sink :: struct {
	enable:    c.int,          //!< Enable sink
	log_level: Logging_Filter, //!< Log messages logged (all, info, warning, error, fatal, debug1, debug2, debug3, debug4)
}

Logging_Provider_File_Configuration :: struct {
	path: cstring, //!< Path to log file (Default: "")
}

Logging_Provider_UDP_Configuration :: struct {
	port: c.uint, //!< UDP port number (Default: 14001)
}

Logging_Provider_Configuration :: struct {
	console:     Logging_Provider_Sink, //!< default: true, log_level_warning | log_level_error | log_level_fatal
	file:        Logging_Provider_Sink, //!< default: false, log_level_none
	udp:         Logging_Provider_Sink, //!< default: true, log_level_info | log_level_warning | log_level_error | log_level_fatal
	file_config: Logging_Provider_File_Configuration,
	udp_config:  Logging_Provider_UDP_Configuration,
}

Logging_Receiver_UDP_Configuration :: struct {
	port: c.uint, //!< UDP port number (Default: 14001)
}

Logging_Receiver_Configuration :: struct {
	enable:     c.int, //!< Enable UDP receiver (Default: false)
	udp_config: Logging_Receiver_UDP_Configuration,
}

Logging_Configuration :: struct {
	provider: Logging_Provider_Configuration,
	receiver: Logging_Receiver_Configuration,
}

