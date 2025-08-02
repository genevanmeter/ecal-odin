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
* @file   ecal_c/timer.h
* @brief  eCAL timer c interface
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

TimerCallbackT :: proc "c" (rawptr)

Timer :: struct {}

@(default_calling_convention="c", link_prefix="eCAL_")
foreign lib {
	/**
	* @brief Creates a new timer instance.
	*
	* @return Timer handle if succeeded, otherwise NULL. The handle needs to be deleted by eCAL_Timer_Delete().
	**/
	Timer_New :: proc() -> ^Timer ---

	/**
	* @brief Deletes a timer instance.
	*
	* @param timer_  Timer handle.
	**/
	Timer_Delete :: proc(timer_: ^Timer) ---

	/**
	* @brief Start the timer.
	*
	* @param timeout_       Timer callback loop time in ms.
	* @param callback_      The callback function.
	* @param user_argument_ User argument that is forwarded to the callback. Optional, can be NULL.
	* @param delay_         Timer callback delay for first call in ms. Optional, can be NULL.
	*
	* @return Zero if succeed, non-zero otherwise.
	**/
	Timer_Start :: proc(timer_: ^Timer, timeout_: c.int, callback_: TimerCallbackT, user_argument_: rawptr, delay_: ^c.int) -> c.int ---

	/**
	* @brief Stop the timer.
	*
	* @return Zero if succeed, non-zero otherwise.
	**/
	Timer_Stop :: proc(timer_: ^Timer) -> c.int ---
}
