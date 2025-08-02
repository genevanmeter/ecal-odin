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
* @file   ecal_c/log.h
* @brief  eCAL logging c interface
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

@(default_calling_convention="c", link_prefix="eCAL_")
foreign lib {
	/**
	* @brief Log a message.
	*
	* @param level_   The level.
	* @param message_ The log message string.
	**/
	Logging_Log :: proc(level_: Logging_eLogLevel, message_: cstring) ---

	/**
	* @brief Get logging as serialized protobuf buffer.
	*
	* @param [out] logging_buffer_         Pointer to a protobuf serialized log buffer. Must point to NULL and needs to be released by eCAL_Free().
	* @param [out] logging_buffer_length_  Length of the log buffer. Must point to zero.
	*
	* @return Zero if succeeded, non-zero otherwise.
	**/
	Logging_GetLoggingBuffer :: proc(logging_buffer_: ^rawptr, logging_buffer_length_: ^c.size_t) -> c.int ---

	/**
	* @brief Get logging as deserialized log messages.
	*
	* @param [out] logging_     Pointer to deserialized log messages. Must point to NULL and needs to be released by eCAL_Free().
	* @param [out] logging_     Pointer to deserialized log messages. Must point to NULL and needs to be released by eCAL_Free().
	*
	* @return Zero if succeeded, non-zero otherwise.
	**/
	Logging_GetLogging :: proc(logging_: ^^Logging_SLogging) -> c.int ---
}
