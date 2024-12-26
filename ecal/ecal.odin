package ecal

Init_Publisher :: 1
Init_Subscriber :: 2
Init_Service :: 4
Init_Monitoring :: 8
Init_Logging :: 16
Init_TimeSync :: 32
Init_RPC :: 64
Init_ProcessReg :: 128
Init_All :: (0x01 | 0x02 | 0x04 | 0x08 | 0x10 | 0x20 | 0x40 | 0x80)
Init_Default :: (0x01 | 0x02 | 0x04 | 0x10 | 0x20 | 0x80)

Process_eSeverity :: enum u32 {proc_sev_unknown = 0, proc_sev_healthy = 1, proc_sev_warning = 2, proc_sev_critical = 3, proc_sev_failed = 4, }
Process_eSeverity_Level :: enum u32 {proc_sev_level1 = 1, proc_sev_level2 = 2, proc_sev_level3 = 3, proc_sev_level4 = 4, proc_sev_level5 = 5, }
Process_eStartMode :: enum u32 {proc_smode_normal = 0, proc_smode_hidden = 1, proc_smode_minimized = 2, proc_smode_maximized = 3, }
ECAL_HANDLE :: rawptr
eQOSPolicy_HistoryKindC :: enum u32 {keep_last_history_qos = 0, keep_all_history_qos = 1, }
eQOSPolicy_ReliabilityC :: enum u32 {best_effort_reliability_qos = 0, reliable_reliability_qos = 1, }
SWriterQOSC :: struct {
    history_kind: eQOSPolicy_HistoryKindC,
    history_kind_depth: i32,
    reliability: eQOSPolicy_ReliabilityC,
}
eTransportLayerC :: enum u32 {tlayer_none = 0, tlayer_udp_mc = 1, tlayer_shm = 4, tlayer_tcp = 5, tlayer_inproc = 42, tlayer_all = 255, }
eSendModeC :: enum i32 {smode_none = -1, smode_off = 0, smode_on = 1, smode_auto = 2, }
Publisher_Event :: enum u32 {pub_event_none = 0, pub_event_connected = 1, pub_event_disconnected = 2, pub_event_dropped = 3, pub_event_update_connection = 4, }
SPubEventCallbackDataC :: struct {
    type: Publisher_Event,
    time: i64,
    clock: i64,
    tid: cstring,
    tname: cstring,
    tencoding: cstring,
    tdesc: cstring,
    ttype: cstring,
}
PubEventCallbackCT :: #type proc "c" (topic_name_: cstring, data_: ^SPubEventCallbackDataC, par_: rawptr)
SReaderQOSC :: struct {
    history_kind: eQOSPolicy_HistoryKindC,
    history_kind_depth: i32,
    reliability: eQOSPolicy_ReliabilityC,
}
SReceiveCallbackDataC :: struct {
    buf: rawptr,
    size: i64,
    id: i64,
    time: i64,
    clock: i64,
}
ReceiveCallbackCT :: #type proc "c" (topic_name_: cstring, data_: ^SReceiveCallbackDataC, par_: rawptr)
Subscriber_Event :: enum u32 {sub_event_none = 0, sub_event_connected = 1, sub_event_disconnected = 2, sub_event_dropped = 3, sub_event_timeout = 4, sub_event_corrupted = 5, sub_event_update_connection = 6, }
SSubEventCallbackDataC :: struct {
    type: Subscriber_Event,
    time: i64,
    clock: i64,
    tid: cstring,
    tname: cstring,
    tencoding: cstring,
    tdesc: cstring,
    ttype: cstring,
}
SubEventCallbackCT :: #type proc "c" (topic_name_: cstring, data_: ^SSubEventCallbackDataC, par_: rawptr)

foreign import ecal_runic "system:ecal_core_c"

@(default_calling_convention = "c")
foreign ecal_runic {
    @(link_name = "eCAL_GetVersionString")
    GetVersionString :: proc() -> cstring ---

    @(link_name = "eCAL_GetVersionDateString")
    GetVersionDateString :: proc() -> cstring ---

    @(link_name = "eCAL_GetVersion")
    GetVersion :: proc(major_: ^i32, minor_: ^i32, patch_: ^i32) -> i32 ---

    @(link_name = "eCAL_Initialize")
    Initialize :: proc(argc_: i32, argv_: ^cstring, unit_name_: cstring, components_: u32) -> i32 ---

    @(link_name = "eCAL_SetUnitName")
    SetUnitName :: proc(unit_name_: cstring) -> i32 ---

    @(link_name = "eCAL_Finalize")
    Finalize :: proc(components_: u32) -> i32 ---

    @(link_name = "eCAL_IsInitialized")
    IsInitialized :: proc(component_: u32) -> i32 ---

    @(link_name = "eCAL_Ok")
    Ok :: proc() -> i32 ---

    @(link_name = "eCAL_FreeMem")
    FreeMem :: proc(mem_: rawptr) ---

    @(link_name = "eCAL_Process_DumpConfig")
    Process_DumpConfig :: proc() ---

    @(link_name = "eCAL_Process_GetHostName")
    Process_GetHostName :: proc(name_: rawptr, name_len_: i32) -> i32 ---

    @(link_name = "eCAL_Process_GetHostID")
    Process_GetHostID :: proc() -> i32 ---

    @(link_name = "eCAL_Process_GetUnitName")
    Process_GetUnitName :: proc(name_: rawptr, name_len_: i32) -> i32 ---

    @(link_name = "eCAL_Process_GetTaskParameter")
    Process_GetTaskParameter :: proc(par_: rawptr, par_len_: i32, sep_: cstring) -> i32 ---

    @(link_name = "eCAL_Process_SleepMS")
    Process_SleepMS :: proc(time_ms_: i64) ---

    @(link_name = "eCAL_Process_GetProcessID")
    Process_GetProcessID :: proc() -> i32 ---

    @(link_name = "eCAL_Process_GetProcessName")
    Process_GetProcessName :: proc(name_: rawptr, name_len_: i32) -> i32 ---

    @(link_name = "eCAL_Process_GetProcessParameter")
    Process_GetProcessParameter :: proc(par_: rawptr, par_len_: i32) -> i32 ---

    @(link_name = "eCAL_Process_GetProcessCpuUsage")
    Process_GetProcessCpuUsage :: proc() -> f32 ---

    @(link_name = "eCAL_Process_GetProcessMemory")
    Process_GetProcessMemory :: proc() -> u64 ---

    @(link_name = "eCAL_Process_GetSClock")
    Process_GetSClock :: proc() -> i64 ---

    @(link_name = "eCAL_Process_GetSBytes")
    Process_GetSBytes :: proc() -> i64 ---

    @(link_name = "eCAL_Process_GetWClock")
    Process_GetWClock :: proc() -> i64 ---

    @(link_name = "eCAL_Process_GetWBytes")
    Process_GetWBytes :: proc() -> i64 ---

    @(link_name = "eCAL_Process_GetRClock")
    Process_GetRClock :: proc() -> i64 ---

    @(link_name = "eCAL_Process_GetRBytes")
    Process_GetRBytes :: proc() -> i64 ---

    @(link_name = "eCAL_Process_SetState")
    Process_SetState :: proc(severity_: Process_eSeverity, level_: Process_eSeverity_Level, info_: cstring) ---

    @(link_name = "eCAL_Process_StartProcess")
    Process_StartProcess :: proc(proc_name_: cstring, proc_args_: cstring, working_dir_: cstring, create_console_: i32, process_mode_: Process_eStartMode, block_: i32) -> i32 ---

    @(link_name = "eCAL_Process_StopProcessName")
    Process_StopProcessName :: proc(proc_name_: cstring) -> i32 ---

    @(link_name = "eCAL_Process_StopProcessID")
    Process_StopProcessID :: proc(proc_id_: i32) -> i32 ---

    @(link_name = "eCAL_Pub_New")
    Pub_New :: proc() -> ECAL_HANDLE ---

    @(link_name = "eCAL_Pub_Create")
    Pub_Create :: proc(handle_: ECAL_HANDLE, topic_name_: cstring, topic_type_: cstring, topic_desc_: cstring, topic_desc_len_: i32) -> i32 ---

    @(link_name = "eCAL_Pub_Destroy")
    Pub_Destroy :: proc(handle_: ECAL_HANDLE) -> i32 ---

    @(link_name = "eCAL_Pub_SetTypeName")
    Pub_SetTypeName :: proc(handle_: ECAL_HANDLE, topic_type_name_: cstring, topic_type_name_len_: i32) -> i32 ---

    @(link_name = "eCAL_Pub_SetDescription")
    Pub_SetDescription :: proc(handle_: ECAL_HANDLE, topic_desc_: cstring, topic_desc_len_: i32) -> i32 ---

    @(link_name = "eCAL_Pub_SetAttribute")
    Pub_SetAttribute :: proc(handle_: ECAL_HANDLE, attr_name_: cstring, attr_name_len_: i32, attr_value_: cstring, attr_value_len_: i32) -> i32 ---

    @(link_name = "eCAL_Pub_ClearAttribute")
    Pub_ClearAttribute :: proc(handle_: ECAL_HANDLE, attr_name_: cstring, attr_name_len_: i32) -> i32 ---

    @(link_name = "eCAL_Pub_ShareType")
    Pub_ShareType :: proc(handle_: ECAL_HANDLE, state_: i32) -> i32 ---

    @(link_name = "eCAL_Pub_ShareDescription")
    Pub_ShareDescription :: proc(handle_: ECAL_HANDLE, state_: i32) -> i32 ---

    @(link_name = "eCAL_Pub_SetQOS")
    Pub_SetQOS :: proc(handle_: ECAL_HANDLE, qos_: SWriterQOSC) -> i32 ---

    @(link_name = "eCAL_Pub_GetQOS")
    Pub_GetQOS :: proc(handle_: ECAL_HANDLE, qos_: ^SWriterQOSC) -> i32 ---

    @(link_name = "eCAL_Pub_SetLayerMode")
    Pub_SetLayerMode :: proc(handle_: ECAL_HANDLE, layer_: eTransportLayerC, mode_: eSendModeC) -> i32 ---

    @(link_name = "eCAL_Pub_SetMaxBandwidthUDP")
    Pub_SetMaxBandwidthUDP :: proc(handle_: ECAL_HANDLE, bandwidth_: i64) -> i32 ---

    @(link_name = "eCAL_Pub_ShmSetBufferCount")
    Pub_ShmSetBufferCount :: proc(handle_: ECAL_HANDLE, buffering_: i64) -> i32 ---

    @(link_name = "eCAL_Pub_ShmEnableZeroCopy")
    Pub_ShmEnableZeroCopy :: proc(handle_: ECAL_HANDLE, state_: i32) -> i32 ---

    @(link_name = "eCAL_Pub_SetID")
    Pub_SetID :: proc(handle_: ECAL_HANDLE, id_: i64) -> i32 ---

    @(link_name = "eCAL_Pub_IsSubscribed")
    Pub_IsSubscribed :: proc(handle_: ECAL_HANDLE) -> i32 ---

    @(link_name = "eCAL_Pub_Send")
    Pub_Send :: proc(handle_: ECAL_HANDLE, buf_: rawptr, buf_len_: i32, time_: i64) -> i32 ---

    @(link_name = "eCAL_Pub_AddEventCallback")
    Pub_AddEventCallback :: proc(handle_: ECAL_HANDLE, type_: Publisher_Event, callback_: PubEventCallbackCT, par_: rawptr) -> i32 ---

    @(link_name = "eCAL_Pub_AddEventCallbackC")
    Pub_AddEventCallbackC :: proc(handle_: ECAL_HANDLE, type_: Publisher_Event, callback_: PubEventCallbackCT, par_: rawptr) -> i32 ---

    @(link_name = "eCAL_Pub_RemEventCallback")
    Pub_RemEventCallback :: proc(handle_: ECAL_HANDLE, type_: Publisher_Event) -> i32 ---

    @(link_name = "eCAL_Pub_Dump")
    Pub_Dump :: proc(handle_: ECAL_HANDLE, buf_: rawptr, buf_len_: i32) -> i32 ---

    @(link_name = "eCAL_Sub_New")
    Sub_New :: proc() -> ECAL_HANDLE ---

    @(link_name = "eCAL_Sub_Create")
    Sub_Create :: proc(handle_: ECAL_HANDLE, topic_name_: cstring, topic_type_: cstring, topic_desc_: cstring, topic_desc_len_: i32) -> i32 ---

    @(link_name = "eCAL_Sub_Destroy")
    Sub_Destroy :: proc(handle_: ECAL_HANDLE) -> i32 ---

    @(link_name = "eCAL_Sub_SetQOS")
    Sub_SetQOS :: proc(handle_: ECAL_HANDLE, qos_: SReaderQOSC) -> i32 ---

    @(link_name = "eCAL_Sub_GetQOS")
    Sub_GetQOS :: proc(handle_: ECAL_HANDLE, qos_: ^SReaderQOSC) -> i32 ---

    @(link_name = "eCAL_Sub_SetID")
    Sub_SetID :: proc(handle_: ECAL_HANDLE, id_array_: ^i64, id_num_: i32) -> i32 ---

    @(link_name = "eCAL_Sub_SetAttribute")
    Sub_SetAttribute :: proc(handle_: ECAL_HANDLE, attr_name_: cstring, attr_name_len_: i32, attr_value_: cstring, attr_value_len_: i32) -> i32 ---

    @(link_name = "eCAL_Sub_ClearAttribute")
    Sub_ClearAttribute :: proc(handle_: ECAL_HANDLE, attr_name_: cstring, attr_name_len_: i32) -> i32 ---

    @(link_name = "eCAL_Sub_Receive")
    Sub_Receive :: proc(handle_: ECAL_HANDLE, buf_: rawptr, buf_len_: i32, time_: ^i64, rcv_timeout_: i32) -> i32 ---

    @(link_name = "eCAL_Sub_Receive_ToBuffer")
    Sub_Receive_ToBuffer :: proc(handle_: ECAL_HANDLE, buf_: rawptr, buf_len_: i32, time_: ^i64, rcv_timeout_: i32) -> i32 ---

    @(link_name = "eCAL_Sub_Receive_Alloc")
    Sub_Receive_Alloc :: proc(handle_: ECAL_HANDLE, buf_: ^rawptr, time_: ^i64, rcv_timeout_: i32) -> i32 ---

    @(link_name = "eCAL_Sub_Receive_Buffer_Alloc")
    Sub_Receive_Buffer_Alloc :: proc(handle_: ECAL_HANDLE, buf_: ^rawptr, buf_len_: ^i32, time_: ^i64, rcv_timeout_: i32) -> i32 ---

    @(link_name = "eCAL_Sub_AddReceiveCallback")
    Sub_AddReceiveCallback :: proc(handle_: ECAL_HANDLE, callback_: ReceiveCallbackCT, par_: rawptr) -> i32 ---

    @(link_name = "eCAL_Sub_AddReceiveCallbackC")
    Sub_AddReceiveCallbackC :: proc(handle_: ECAL_HANDLE, callback_: ReceiveCallbackCT, par_: rawptr) -> i32 ---

    @(link_name = "eCAL_Sub_RemReceiveCallback")
    Sub_RemReceiveCallback :: proc(handle_: ECAL_HANDLE) -> i32 ---

    @(link_name = "eCAL_Sub_AddEventCallback")
    Sub_AddEventCallback :: proc(handle_: ECAL_HANDLE, type_: Subscriber_Event, callback_: SubEventCallbackCT, par_: rawptr) -> i32 ---

    @(link_name = "eCAL_Sub_AddEventCallbackC")
    Sub_AddEventCallbackC :: proc(handle_: ECAL_HANDLE, type_: Subscriber_Event, callback_: SubEventCallbackCT, par_: rawptr) -> i32 ---

    @(link_name = "eCAL_Sub_RemEventCallback")
    Sub_RemEventCallback :: proc(handle_: ECAL_HANDLE, type_: Subscriber_Event) -> i32 ---

    @(link_name = "eCAL_Sub_GetTypeName")
    Sub_GetTypeName :: proc(handle_: ECAL_HANDLE, buf_: rawptr, buf_len_: i32) -> i32 ---

    @(link_name = "eCAL_Sub_GetEncoding")
    Sub_GetEncoding :: proc(handle_: ECAL_HANDLE, buf_: rawptr, buf_len_: i32) -> i32 ---

    @(link_name = "eCAL_Sub_GetDescription")
    Sub_GetDescription :: proc(handle_: ECAL_HANDLE, buf_: rawptr, buf_len_: i32) -> i32 ---

    @(link_name = "eCAL_Sub_SetTimeout")
    Sub_SetTimeout :: proc(handle_: ECAL_HANDLE, timeout_: i32) -> i32 ---

    @(link_name = "eCAL_Sub_Dump")
    Sub_Dump :: proc(handle_: ECAL_HANDLE, buf_: rawptr, buf_len_: i32) -> i32 ---

}

