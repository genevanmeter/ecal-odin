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
* @file   types/logging.h
* @brief  eCAL logging types
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

Logging_SLogMessage :: struct {
	time:         i64,               // time
	host_name:    cstring,           // host name
	process_id:   i32,               // process id
	process_name: cstring,           // process name
	unit_name:    cstring,           // unit name
	level:        Logging_eLogLevel, // message level
	content:      cstring,           // message content
}

Logging_SLogging :: struct {
	log_messages:        ^Logging_SLogMessage, // log messages
	log_messages_length: c.size_t,             // array of log messages
}

