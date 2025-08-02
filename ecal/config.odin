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
* @file   config.h
* @brief  eCAL configuration access
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

@(default_calling_convention="c", link_prefix="eCAL_")
foreign lib {
	/////////////////////////////////////
	// configuration
	/////////////////////////////////////
	GetConfiguration           :: proc() -> ^Configuration ---
	GetSubscriberConfiguration :: proc() -> ^Subscriber_Configuration ---
	GetPublisherConfiguration  :: proc() -> ^Publisher_Configuration ---

	/////////////////////////////////////
	// common
	/////////////////////////////////////
	Config_GetLoadedEcalYamlPath    :: proc() -> cstring ---
	Config_GetRegistrationTimeoutMs :: proc() -> c.int ---
	Config_GetRegistrationRefreshMs :: proc() -> c.int ---

	/////////////////////////////////////
	// network
	/////////////////////////////////////
	Config_IsNetworkEnabled                   :: proc() -> c.int ---
	Config_IsShmRegistrationEnabled           :: proc() -> c.int ---
	Config_GetUdpMulticastConfigVersion       :: proc() -> Types_UdpConfigVersion ---
	Config_GetUdpMulticastGroup               :: proc() -> cstring ---
	Config_GetUdpMulticastMask                :: proc() -> cstring ---
	Config_GetUdpMulticastPort                :: proc() -> c.int ---
	Config_GetUdpMulticastTtl                 :: proc() -> c.int ---
	Config_GetUdpMulticastSndBufSizeBytes     :: proc() -> c.int ---
	Config_GetUdpMulticastRcvBufSizeBytes     :: proc() -> c.int ---
	Config_IsUdpMulticastJoinAllIfEnabled     :: proc() -> c.int ---
	Config_IsUdpMulticastRecEnabled           :: proc() -> c.int ---
	Config_IsShmRecEnabled                    :: proc() -> c.int ---
	Config_IsTcpRecEnabled                    :: proc() -> c.int ---
	Config_IsNpcapEnabled                     :: proc() -> c.int ---
	Config_GetTcpPubsubReaderThreadpoolSize   :: proc() -> c.size_t ---
	Config_GetTcpPubsubWriterThreadpoolSize   :: proc() -> c.size_t ---
	Config_GetTcpPubsubMaxReconnectionAttemps :: proc() -> c.int ---
	Config_GetShmTransportDomain              :: proc() -> cstring ---

	/////////////////////////////////////
	// time
	/////////////////////////////////////
	Config_GetTimesyncModuleName   :: proc() -> cstring ---
	Config_GetTimesyncModuleReplay :: proc() -> cstring ---

	/////////////////////////////////////
	// process
	/////////////////////////////////////
	Config_GetTerminalEmulatorCommand :: proc() -> cstring ---

	/////////////////////////////////////
	// sys
	/////////////////////////////////////
	Config_GetEcalSysFilterExcludeList :: proc() -> cstring ---

	/////////////////////////////////////
	// subscriber
	/////////////////////////////////////
	Config_GetDropOutOfOrderMessages :: proc() -> c.int ---

	/////////////////////////////////////
	// registration
	/////////////////////////////////////
	Config_GetShmMonitoringQueueSize :: proc() -> c.size_t ---
	Config_GetShmMonitoringDomain    :: proc() -> cstring ---
}
