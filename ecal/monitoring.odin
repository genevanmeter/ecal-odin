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
* @file   ecal_c/monitoring.h
* @brief  eCAL monitoring c interface
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

@(default_calling_convention="c", link_prefix="eCAL_")
foreign lib {
	/**
	* @brief Get monitoring as serialized protobuf buffer.
	*
	* @param [out] monitoring_buffer          Pointer to a protobuf serialized monitoring buffer. Must point to NULL and needs to be released by eCAL_Free().
	* @param [out] monitoring_buffer_length_  Length of the log buffer.
	* @param       entities_                  Entities to be included. Optional, can be NULL.
	*
	* @return Zero if succeeded, non-zero otherwise.
	**/
	Monitoring_GetMonitoringBuffer :: proc(monitoring_buffer_: ^rawptr, monitoring_buffer_length_: ^c.size_t, entities_: ^c.uint) -> c.int ---

	/**
	* @brief Get monitoring as deserialized structure.
	*
	* @param [out] monitoring_  Pointer to a deserialized monitoring structure. Must point to NULL and needs to be released by eCAL_Free().
	* @param       entities_    Entities to be included. Optional, can be NULL.
	*
	* @return Zero if succeeded, non-zero otherwise.
	**/
	Monitoring_GetMonitoring :: proc(monitoring_: ^^Monitoring_SMonitoring, entities_: ^c.uint) -> c.int ---
}
