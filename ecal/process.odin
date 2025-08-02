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
* @file   ecal_c/process.h
* @brief  eCAL process c interface
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

@(default_calling_convention="c", link_prefix="eCAL_")
foreign lib {
	/**
	* @brief  Dump configuration to console.
	**/
	Process_DumpConfig :: proc() ---

	/**
	* @brief  Dump configiguration into null-terminated string
	*
	* @param[out] configuration_ Returned null-terminated configuration string. Must point to NULL and needs to be released by eCAL_Free().
	*
	**/
	Process_DumpConfigString :: proc(configuration_: [^]cstring) ---

	/**
	* @brief  Get current host name.
	*
	* @return Host name if suceeded, empty string otherwise.
	**/
	Process_GetHostName :: proc() -> cstring ---

	/**
	* @brief  Get current SHM transport domain.
	*
	* @return SHM transport domain if suceeded, empty string otherwise.
	**/
	Process_GetShmTransportDomain :: proc() -> cstring ---

	/**
	* @brief  Get current unit name (defined via eCAL::Initialize).
	*
	* @return  Unit name if suceeded, empty string otherwise.
	**/
	Process_GetUnitName :: proc() -> cstring ---

	/**
	* @brief  Sleep current thread.
	*
	* Because of the fact that std::this_thread::sleep_for is vulnerable to system clock changes
	* on Windows, Sleep function from synchapi.h had to be used for Windows. This insures time
	* robustness on all platforms from a thread sleep perspective.
	*
	* @param  time_ms_  Time to sleep in ms.
	**/
	Process_SleepMS :: proc(time_ms_: c.long) ---

	/**
	* @brief  Sleep current thread.
	*
	* Because of the fact that std::this_thread::sleep_for is vulnerable to system clock changes
	* on Windows, Sleep function from synchapi.h had to be used for Windows. This insures time
	* robustness on all platforms from a thread sleep perspective. Used with ns unit to obtain bigger precision.
	*
	* @param  time_ns_  Time to sleep in ns.
	**/
	Process_SleepNS :: proc(time_ns_: c.longlong) ---

	/**
	* @brief  Get current process id.
	*
	* @return  The process id.
	**/
	Process_GetProcessID :: proc() -> c.int ---

	/**
	* @brief  Get current process id as string.
	*
	* @return  The process id if suceeded, empty string otherwise.
	**/
	Process_GetProcessIDAsString :: proc() -> cstring ---

	/**
	* @brief  Get current process name.
	*
	* @return Process name if suceeded, empty string otherwise.
	**/
	Process_GetProcessName :: proc() -> cstring ---

	/**
	* @brief  Get current process parameter.
	*
	* @return  Process parameter if suceeded, empty string otherwise.
	**/
	Process_GetProcessParameter :: proc() -> cstring ---

	/**
	* @brief  Set process state info.
	*
	* @param severity_  Severity.
	* @param level_     Severity level.
	* @param info_      Info message.
	*
	**/
	Process_SetState :: proc(severity_: Process_eSeverity, level_: Process_eSeverityLevel, info_: cstring) ---
}
