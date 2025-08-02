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

/**
* @brief Values that represent different log level to filter on monitoring.
**/
Logging_eLogLevel :: enum c.int {
	none    = 0,
	all     = 255,
	info    = 1,
	warning = 2,
	error   = 4,
	fatal   = 8,
	debug1  = 16,
	debug2  = 32,
	debug3  = 64,
	debug4  = 128,
}

Logging_Filter :: c.uchar //!< This type is to be used as a bitmask for the activated logging levels

