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
* @file   ecal_c/types.h
* @brief  File including shared types for eCAL C API
**/
package ecal

import "core:c"

_ :: c

foreign import lib "system:libecal_core_c.so"

/**
* @brief Optional compile time information associated with a given topic
*        (necessary for reflection / runtime type checking)
**/
SDataTypeInformation :: struct {
	name:              cstring,  //!< name of the datatype
	encoding:          cstring,  //!< encoding of the datatype (e.g. protobuf, flatbuffers, capnproto)
	descriptor:        rawptr,   //!< descriptor information of the datatype (necessary for reflection)
	descriptor_length: c.size_t, //!< length of descriptor information
}

EntityIdT :: u64

/**
* @brief Combined meta infomration for an eCAL entity such as publisher, subscriber, etc.
**/
SEntityId :: struct {
	entity_id:  EntityIdT, //!< unique id within that process (it should already be unique within the whole system)
	process_id: i32,       //!< process id which produced the sample
	host_name:  cstring,   //!< host which produced the sample
}

/**
* @brief eCAL version struct (C variant)
**/
SVersion :: struct {
	major: c.int, //!< major version number
	minor: c.int, //!< minor version number
	patch: c.int, //!< patch version number
}

