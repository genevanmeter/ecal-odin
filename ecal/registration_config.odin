/* =========================== LICENSE =================================
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
* =========================== LICENSE =================================
*/
/**
* @file   config/registration.h
* @brief  eCAL configuration for the registration layer
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

Registration_Local_eTransportType :: enum c.int {
	shm,
	udp,
}

Registration_Local_SHM_Configuration :: struct {
	domain:     cstring,  //!< Domain name for shared memory based registration (Default: ecal_mon)
	queue_size: c.size_t, //!< Queue size of registration events (Default: 1024)
}

Registration_Local_UDP_Configuration :: struct {
	port: c.uint, //!< UDP broadcast port number (Default: 14000)
}

Registration_Local_Configuration :: struct {
	transport_type: Registration_Local_eTransportType, //!< Transport type for registration (Default: udp)
	shm:            Registration_Local_SHM_Configuration,
	udp:            Registration_Local_UDP_Configuration,
}

Registration_Network_eTransportType :: enum c.int {
	eCAL_Registration_Network_eTransportType_udp,
}

Registration_Network_UDP_Configuration :: struct {
	port: c.uint, //!< UDP multicast port number (Default: 14000)
}

Registration_Network_Configuration :: struct {
	transport_type: Registration_Network_eTransportType, //!< Transport type for registration (Default: udp)
	udp:            Registration_Network_UDP_Configuration,
}

Registration_Configuration :: struct {
	registration_timeout: c.uint,  //!< Timeout for topic registration in ms (internal) (Default: 10000)
	registration_refresh: c.uint,  //!< Topic registration refresh cycle (has to be smaller than registration timeout!) (Default: 1000)
	loopback:             c.int,   //!< Enable to receive UDP messages on the same local machine (Default: true)
	shm_transport_domain: cstring, //!< Common shm transport domain that enables interprocess mechanisms across (virtual) host borders (e.g., Docker); by default equivalent to local host name (Default: "")
	local:                Registration_Local_Configuration,
	network:              Registration_Network_Configuration,
}

