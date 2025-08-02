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
* @file   ecal_c/core.h
* @brief  eCAL core function c interface
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

@(default_calling_convention="c", link_prefix="eCAL_")
foreign lib {
	/**
	* @brief  Get eCAL version string.
	*
	* @return  Full eCAL version string.
	**/
	GetVersionString :: proc() -> cstring ---

	/**
	* @brief  Get eCAL version date.
	*
	* @return  Full eCAL version date string.
	**/
	GetVersionDateString :: proc() -> cstring ---

	/**
	* @brief  Get eCAL version as separated integer values.
	*
	* @return eCAL version struct with seperate version values
	*
	**/
	GetVersion :: proc() -> SVersion ---

	/**
	* @brief Initialize eCAL API.
	*
	* @param unit_name_   Defines the name of the eCAL unit. Optional, can be NULL.
	* @param components_  Defines which component to initialize. Optional, can be NULL.
	* @param config_      Configuration with which eCal is to be initialized. Optional, can be NULL.
	*
	* @return Zero if succeeded, non-zero otherwise.
	**/
	Initialize :: proc(unit_name_: cstring, components_: ^c.uint, config_: ^Configuration) -> c.int ---

	/**
	* @brief Finalize eCAL API.
	*
	* @return Zero if succeeded, non-zero otherwise.
	**/
	Finalize :: proc() -> c.int ---

	/**
	* @brief Check eCAL initialize state.
	*
	* @return Non-zero if eCAL is initialized, zero otherwise.
	**/
	IsInitialized :: proc() -> c.int ---

	/**
	* @brief Check initialize state of components.
	*
	* @param components_ Components to be checked.
	*
	* @return Non-zero if eCAL is initialized, zero otherwise.
	**/
	IsComponentInitialized :: proc(components_: c.uint) -> c.int ---

	/**
	* @brief Return the eCAL process state.
	*
	* @return Non-zero if eCAL is in proper state, zero otherwise.
	**/
	Ok :: proc() -> c.int ---
}
