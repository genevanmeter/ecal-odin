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
* @file   ecal_c/time.h
* @brief  eCAL time c interface
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

@(default_calling_convention="c", link_prefix="eCAL_")
foreign lib {
	Time_GetName :: proc() -> cstring ---

	/**
	* @brief  Get current time
	*
	* @return  current time in us.
	**/
	Time_GetMicroSeconds :: proc() -> c.longlong ---

	/**
	* @brief  Get current time
	*
	* @return  current time in ns.
	**/
	Time_GetNanoSeconds :: proc() -> c.longlong ---

	/**
	* @brief  Set current time in nano seconds if host is time master.
	*
	* @param time_  Current time in ns.
	*
	* @return  Zero if succeeded, non-zero otherwise.
	**/
	Time_SetNanoSeconds :: proc(time_: c.longlong) -> c.int ---

	/**
	* @brief  Returns time synchronization state.
	*
	* @return  Non-zero if process is time synchronized, zero otherwise.
	**/
	Time_IsTimeSynchronized :: proc() -> c.int ---

	/**
	* @brief  Checks whether this host is time master.
	*
	* @return  Non-zero if host is time master, zero otherwise.
	**/
	Time_IsTimeMaster :: proc() -> c.int ---

	/**
	* @brief Blocks for the given amount of nanoseconds.
	*
	* The actual amount of (real-) time is influenced by the current rate at
	* which the time is proceeding.
	* It is not guaranteed, that the precision of this function actually  is in
	* nanoseconds. Limitations of the operating system might reduce the accuracy.
	*
	* @param duration_nsecs_ the duration in nanoseconds
	**/
	Time_SleepForNanoseconds :: proc(duration_nsecs_: c.longlong) ---

	/**
	* @brief Get the current error code and status message
	*
	* An error code of 0 is considered to be OK. Any other error code is
	* considered to indicate a problem. Time Adapters may use a set of error
	* codes to indicate specific problems.
	* The Status message may be a nullpointer.
	*
	* @param[out] error_           Returned error code
	* @param[out] status_message_  Returned null-terminated string of status message which may be NULL. Must point to NULL and needs to be released by eCAL_Free().
	**/
	Time_GetStatus :: proc(error_: ^c.int, status_message_: [^]cstring) ---
}
