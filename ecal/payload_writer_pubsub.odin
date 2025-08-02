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
* @file   pubsub/payload_writer.h
* @brief  eCAL payload writer c interface
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

/**
* @brief Payload writer interface to allow zero copy memory operations.
*
* This interface struct can be used for enabling  zero-copy memory
* operations. The `WriteFull` and `WriteModified` calls may operate on the target
* memory file directly in zero-copy mode.
*
* A partial writing / modification of the memory file is only possible when zero-copy mode
* is activated. If zero-copy is not enabled, the `WriteModified` method is ignored and the
* `WriteFull` method is always executed.
*
**/
PayloadWriter :: struct {
	WriteFull:     proc "c" (rawptr, c.size_t) -> c.int, /*buffer_*/
	WriteModified: proc "c" (rawptr, c.size_t) -> c.int, /*buffer_*/

	/**
	* @brief Get the size of the required memory.
	*
	* This function pointer must be set to provide the size of the memory
	* that eCAL needs to allocate.
	*
	* @return The size of the required memory.
	**/
	GetSize: proc "c" () -> c.size_t,
}

