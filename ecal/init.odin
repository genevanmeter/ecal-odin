/* ========================= eCAL LICENSE =================================
*
* Copyright (C) 2016 - 2019 Continental Corporation
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
* @file   ecal_c/init.h
* @brief  eCAL initialize components
**/
package ecal



foreign import lib "system:libecal_core_c.so"

ECAL_INIT_PUBLISHER  :: 0x001
ECAL_INIT_SUBSCRIBER :: 0x002
ECAL_INIT_SERVICE    :: 0x004
ECAL_INIT_MONITORING :: 0x008
ECAL_INIT_LOGGING    :: 0x010
ECAL_INIT_TIMESYNC   :: 0x020
ECAL_INIT_NONE       :: 0x000

@(default_calling_convention="c", link_prefix="eCAL_")
foreign lib {
	/**
	* @brief Convenience function for initializing a new configuration
	*
	* @return Handle to configuration instance if succeeded, NULL otherwise. The handle needs to be released by eCAL_Coniguration_Delete().
	**/
	Init_Configuration :: proc() -> ^Configuration ---
}
