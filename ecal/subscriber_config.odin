/* ========================= eCAL LICENSE =================================
*
* Copyright (C) 2016 - 2024 Continental Corporation
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
* @file   config/subscriber.h
* @brief  eCAL subscriber configuration
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

Subscriber_Layer_SHM_Configuration :: struct {
	enable: c.int, //!< enable layer (Default: true)
}

Subscriber_Layer_UDP_Configuration :: struct {
	enable: c.int, //!< enable layer (Default: true)
}

Subscriber_Layer_TCP_Configuration :: struct {
	enable: c.int, //!< enable layer (Default: false)
}

Subscriber_Layer_Configuration :: struct {
	shm: Subscriber_Layer_SHM_Configuration,
	udp: Subscriber_Layer_UDP_Configuration,
	tcp: Subscriber_Layer_TCP_Configuration,
}

Subscriber_Configuration :: struct {
	layer:                      Subscriber_Layer_Configuration,
	drop_out_of_order_messages: c.int, //!< Enable dropping of payload messages that arrive out of order (Default: true)
}

