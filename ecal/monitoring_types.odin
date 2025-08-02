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
* @file   types/monitoring.h
* @brief  eCAL monitoring types
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

ECAL_MONITORING_ENTITY_PUBLISHER  :: 0x001
ECAL_MONITORING_ENTITY_SUBSCRIBER :: 0x002
ECAL_MONITORING_ENTITY_SERVER     :: 0x004
ECAL_MONITORING_ENTITY_CLIENT     :: 0x008
ECAL_MONITORING_ENTITY_PROCESS    :: 0x010
ECAL_MONITORING_ENTITY_HOST       :: 0x020
ECAL_MONITORING_ENTITY_NONE       :: 0x000

Monitoring_eTransportLayerType :: enum c.int {
	none   = 0,
	udp_mc = 1,
	shm    = 4,
	tcp    = 5,
}

Monitoring_STransportLayer :: struct {
	type:    Monitoring_eTransportLayerType, // transport layer type
	version: i32,                            // transport layer version
	active:  c.int,                          // transport layer used?
}

Monitoring_STopic :: struct {
	registration_clock:     i32,                         // registration clock (heart beat)
	host_name:              cstring,                     // host name
	shm_transport_domain:   cstring,                     // shm transport domain
	process_id:             i32,                         // process id
	process_name:           cstring,                     // process name
	unit_name:              cstring,                     // unit name
	topic_id:               i64,                         // topic id
	topic_name:             cstring,                     // topic name
	direction:              cstring,                     // direction (publisher, subscriber)
	datatype_information:   SDataTypeInformation,        // topic datatype information (name, encoding, descriptor)
	transport_layer:        ^Monitoring_STransportLayer, // transport layer details
	transport_layer_length: c.size_t,                    // array of transport layer details
	topic_size:             i32,                         // topic size
	connections_local:      i32,                         // number of local connected entities
	connections_external:   i32,                         // number of external connected entities
	message_drops:          i32,                         // dropped messages
	data_id:                i64,                         // data send id (publisher setid)
	data_clock:             i64,                         // data clock (send / receive action)
	data_frequency:         i32,                         // data frequency (send / receive samples per second) [mHz]
}

Monitoring_SProcess :: struct {
	registration_clock:    i32,     // registration clock
	host_name:             cstring, // host name
	shm_transport_domain:  cstring, // shm transport domain
	process_id:            i32,     // process id
	process_name:          cstring, // process name
	unit_name:             cstring, // unit name
	process_parameter:     cstring, // process parameter
	state_severity:        i32,     // process state info severity
	state_severity_level:  i32,     // process state info severity level
	state_info:            cstring, // process state info as human readable string
	time_sync_state:       i32,     // time synchronization state
	time_sync_module_name: cstring, // time synchronization module name
	component_init_state:  i32,     // eCAL component initialization state (eCAL::Initialize(..))
	component_init_info:   cstring, // like comp_init_state as human readable string (pub/sub/srv/mon/log/time/proc)
	ecal_runtime_version:  cstring, // loaded / runtime eCAL version of a component
	config_file_path:      cstring, // Filepath of the configuration filepath that was loaded
}

Monitoring_SMethod :: struct {
	method_name:                   cstring,              // method name
	request_datatype_information:  SDataTypeInformation, // request datatype information (encoding & type & description)
	response_datatype_information: SDataTypeInformation, // response datatype information (encoding & type & description)
	call_count:                    c.longlong,           // call counter
}

Monitoring_SServer :: struct {
	registration_clock: i32,                 // registration clock
	host_name:          cstring,             // host name
	process_name:       cstring,             // process name
	unit_name:          cstring,             // unit name
	process_id:         i32,                 // process id
	service_name:       cstring,             // service name
	service_id:         i64,                 // service id
	version:            u32,                 // service protocol version
	tcp_port_v0:        u32,                 // the tcp port protocol version 0 used for that service
	tcp_port_v1:        u32,                 // the tcp port protocol version 1 used for that service
	methods:            ^Monitoring_SMethod, // list of methods
	methods_length:     c.size_t,            // array of methods
}

Monitoring_SClient :: struct {
	registration_clock: i32,                 // registration clock
	host_name:          cstring,             // host name
	process_name:       cstring,             // process name
	unit_name:          cstring,             // unit name
	process_id:         i32,                 // process id
	service_name:       cstring,             // service name
	service_id:         i64,                 // service id
	methods:            ^Monitoring_SMethod, // list of methods
	methods_length:     c.size_t,            // array of methods
	version:            u32,                 // client protocol version
}

Monitoring_SMonitoring :: struct {
	processes:          ^Monitoring_SProcess, // process info
	processes_length:   c.size_t,             // array of process info
	publishers:         ^Monitoring_STopic,   // publisher info array
	publishers_length:  c.size_t,             // array of publisher info
	subscribers:        ^Monitoring_STopic,   // subscriber info array
	subscribers_length: c.size_t,             // array of subscriber info
	servers:            ^Monitoring_SServer,  // server info array
	servers_length:     c.size_t,             // array of server info
	clients:            ^Monitoring_SClient,  // clients info array
	clients_length:     c.size_t,             // array of clients info
}

