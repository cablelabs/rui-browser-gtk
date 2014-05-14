/* gupnp-1.0.vapi generated by vapigen, do not modify. */

[CCode (cprefix = "GUPnP", gir_namespace = "GUPnP", gir_version = "1.0", lower_case_cprefix = "gupnp_")]
namespace GUPnP {
	[CCode (cheader_filename = "libgupnp/gupnp.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gupnp_bin_base64_get_type ()")]
	[Compact]
	public class BinBase64 {
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gupnp_bin_hex_get_type ()")]
	[Compact]
	public class BinHex {
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", type_id = "gupnp_context_get_type ()")]
	public class Context : GSSDP.Client, GLib.Initable {
		[CCode (has_construct_function = false)]
		public Context (GLib.MainContext? main_context, string? iface, uint port) throws GLib.Error;
		public unowned string get_default_language ();
		[Deprecated (since = "0.12.7")]
		public unowned string get_host_ip ();
		public uint get_port ();
		public unowned Soup.Server get_server ();
		public unowned Soup.Session get_session ();
		public uint get_subscription_timeout ();
		public void host_path (string local_path, string server_path);
		public bool host_path_for_agent (string local_path, string server_path, GLib.Regex user_agent);
		public void set_default_language (string language);
		public void set_subscription_timeout (uint timeout);
		public void unhost_path (string server_path);
		public string default_language { get; set construct; }
		public uint port { get; construct; }
		public Soup.Server server { get; }
		public Soup.Session session { get; }
		public uint subscription_timeout { get; construct; }
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", type_id = "gupnp_context_manager_get_type ()")]
	public abstract class ContextManager : GLib.Object {
		[CCode (has_construct_function = false)]
		protected ContextManager ();
		public static GUPnP.ContextManager create (uint port);
		public uint get_port ();
		public unowned GUPnP.WhiteList get_white_list ();
		public void manage_control_point (GUPnP.ControlPoint control_point);
		public void manage_root_device (GUPnP.RootDevice root_device);
		public void rescan_control_points ();
		public uint port { get; construct; }
		public GUPnP.WhiteList white_list { get; }
		public signal void context_available (GUPnP.Context context);
		public signal void context_unavailable (GUPnP.Context context);
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", type_id = "gupnp_control_point_get_type ()")]
	public class ControlPoint : GSSDP.ResourceBrowser {
		[CCode (has_construct_function = false)]
		public ControlPoint (GUPnP.Context context, string target);
		[CCode (has_construct_function = false)]
		public ControlPoint.full (GUPnP.Context context, GUPnP.ResourceFactory factory, string target);
		public unowned GUPnP.Context get_context ();
		public unowned GUPnP.ResourceFactory get_resource_factory ();
		public unowned GLib.List<GUPnP.DeviceProxy> list_device_proxies ();
		public unowned GLib.List<GUPnP.ServiceProxy> list_service_proxies ();
		public GUPnP.ResourceFactory resource_factory { get; construct; }
		public virtual signal void device_proxy_available (GUPnP.DeviceProxy proxy);
		public virtual signal void device_proxy_unavailable (GUPnP.DeviceProxy proxy);
		public virtual signal void service_proxy_available (GUPnP.ServiceProxy proxy);
		public virtual signal void service_proxy_unavailable (GUPnP.ServiceProxy proxy);
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gupnp_date_get_type ()")]
	[Compact]
	public class Date {
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gupnp_date_time_get_type ()")]
	[Compact]
	public class DateTime {
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gupnp_date_time_tz_get_type ()")]
	[Compact]
	public class DateTimeTZ {
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", type_id = "gupnp_device_get_type ()")]
	public class Device : GUPnP.DeviceInfo {
		[CCode (has_construct_function = false)]
		protected Device ();
		[NoAccessorMethod]
		public GUPnP.RootDevice root_device { owned get; construct; }
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", type_id = "gupnp_device_info_get_type ()")]
	public abstract class DeviceInfo : GLib.Object {
		[CCode (has_construct_function = false)]
		protected DeviceInfo ();
		public unowned GUPnP.Context get_context ();
		public string get_description_value (string element);
		public GUPnP.DeviceInfo? get_device (string type);
		public unowned string get_device_type ();
		public string get_friendly_name ();
		public string get_icon_url (string? requested_mime_type, int requested_depth, int requested_width, int requested_height, bool prefer_bigger, out string mime_type, out int depth, out int width, out int height);
		public unowned string get_location ();
		public string get_manufacturer ();
		public string get_manufacturer_url ();
		public string get_model_description ();
		public string get_model_name ();
		public string get_model_number ();
		public string get_model_url ();
		public string get_presentation_url ();
		public unowned GUPnP.ResourceFactory get_resource_factory ();
		public string get_serial_number ();
		public GUPnP.ServiceInfo? get_service (string type);
		public unowned string get_udn ();
		public string get_upc ();
		public unowned Soup.URI get_url_base ();
		public GLib.List<string> list_device_types ();
		public GLib.List<GUPnP.DeviceInfo> list_devices ();
		public GLib.List<string> list_dlna_capabilities ();
		public GLib.List<string> list_dlna_device_class_identifier ();
		public GLib.List<string> list_service_types ();
		public GLib.List<GUPnP.ServiceInfo> list_services ();
		public GUPnP.Context context { get; construct; }
		public string device_type { get; construct; }
		public string location { get; construct; }
		public GUPnP.ResourceFactory resource_factory { get; construct; }
		public string udn { get; construct; }
		public Soup.URI url_base { get; construct; }
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", type_id = "gupnp_device_proxy_get_type ()")]
	public class DeviceProxy : GUPnP.DeviceInfo {
		[CCode (has_construct_function = false)]
		protected DeviceProxy ();
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", type_id = "gupnp_resource_factory_get_type ()")]
	public class ResourceFactory : GLib.Object {
		[CCode (has_construct_function = false)]
		public ResourceFactory ();
		public static unowned GUPnP.ResourceFactory get_default ();
		public void register_resource_proxy_type (string upnp_type, GLib.Type type);
		public void register_resource_type (string upnp_type, GLib.Type type);
		public bool unregister_resource_proxy_type (string upnp_type);
		public bool unregister_resource_type (string upnp_type);
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", type_id = "gupnp_root_device_get_type ()")]
	public class RootDevice : GUPnP.Device {
		[CCode (has_construct_function = false)]
		public RootDevice (GUPnP.Context context, string description_path, string description_dir);
		[CCode (has_construct_function = false)]
		public RootDevice.full (GUPnP.Context context, GUPnP.ResourceFactory factory, GUPnP.XMLDoc description_doc, string description_path, string description_dir);
		public bool get_available ();
		public unowned string get_description_dir ();
		public unowned string get_description_path ();
		public unowned string get_relative_location ();
		public unowned GSSDP.ResourceGroup get_ssdp_resource_group ();
		public void set_available (bool available);
		public bool available { get; set; }
		public string description_dir { get; construct; }
		public GUPnP.XMLDoc description_doc { construct; }
		public string description_path { get; construct; }
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", type_id = "gupnp_service_get_type ()")]
	public class Service : GUPnP.ServiceInfo {
		[CCode (has_construct_function = false)]
		protected Service ();
		public void freeze_notify ();
		public void notify (...);
		public void notify_value (string variable, GLib.Value value);
		public void thaw_notify ();
		[NoAccessorMethod]
		public GUPnP.RootDevice root_device { owned get; construct; }
		public virtual signal void action_invoked (GUPnP.ServiceAction action);
		public signal void notify_failed (GLib.List<Soup.URI> callback_url, GLib.Error reason);
		public virtual signal void query_variable (string variable, ref GLib.Value value);
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gupnp_service_action_get_type ()")]
	[Compact]
	public class ServiceAction {
		public void @get (...);
		public uint get_argument_count ();
		public GLib.Value? get_gvalue (string argument, GLib.Type type);
		public GLib.List<string> get_locales ();
		public Soup.Message get_message ();
		public unowned string get_name ();
		public void get_value (string argument, ref GLib.Value value);
		public GLib.List<GLib.Value?> get_values (GLib.List<string> arg_names, GLib.List<GLib.Type?> arg_types);
		public void @return ();
		public void return_error (uint error_code, string error_description);
		public void @set (...);
		public void set_value (string argument, GLib.Value value);
		public void set_values (GLib.List<string> arg_names, GLib.List<GLib.Value?> arg_values);
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", type_id = "gupnp_service_info_get_type ()")]
	public abstract class ServiceInfo : GLib.Object {
		[CCode (has_construct_function = false)]
		protected ServiceInfo ();
		public unowned GUPnP.Context get_context ();
		public string get_control_url ();
		public string get_event_subscription_url ();
		public string get_id ();
		public GUPnP.ServiceIntrospection? get_introspection () throws GLib.Error;
		public void get_introspection_async ([CCode (scope = "async")] owned GUPnP.ServiceIntrospectionCallback callback);
		public void get_introspection_async_full ([CCode (delegate_target_pos = 2.1, scope = "async")] owned GUPnP.ServiceIntrospectionCallback callback, GLib.Cancellable? cancellable);
		public unowned string get_location ();
		public string get_scpd_url ();
		public unowned string get_service_type ();
		public unowned string get_udn ();
		public unowned Soup.URI get_url_base ();
		public GUPnP.Context context { get; construct; }
		public string location { get; construct; }
		public string service_type { get; construct; }
		public string udn { get; construct; }
		public Soup.URI url_base { get; construct; }
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", type_id = "gupnp_service_introspection_get_type ()")]
	public class ServiceIntrospection : GLib.Object {
		[CCode (has_construct_function = false)]
		protected ServiceIntrospection ();
		public unowned GUPnP.ServiceActionInfo? get_action (string action_name);
		public unowned GUPnP.ServiceStateVariableInfo? get_state_variable (string variable_name);
		public unowned GLib.List<string> list_action_names ();
		public unowned GLib.List<GUPnP.ServiceActionInfo> list_actions ();
		public unowned GLib.List<string> list_state_variable_names ();
		public unowned GLib.List<GUPnP.ServiceStateVariableInfo> list_state_variables ();
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h")]
	public class ServiceProxy : GUPnP.ServiceInfo {
		[CCode (has_construct_function = false)]
		protected ServiceProxy ();
		public bool add_notify (string variable, GLib.Type type, [CCode (scope = "async")] owned GUPnP.ServiceProxyNotifyCallback callback);
		public unowned GUPnP.ServiceProxyAction begin_action (string action, [CCode (delegate_target_pos = 2.5, scope = "async")] owned GUPnP.ServiceProxyActionCallback callback, ...);
		[Deprecated (since = "0.20.9")]
		public unowned GUPnP.ServiceProxyAction begin_action_hash (string action, [CCode (delegate_target_pos = 2.5, scope = "async")] owned GUPnP.ServiceProxyActionCallback callback, GLib.HashTable<string,GLib.Value?> hash);
		public unowned GUPnP.ServiceProxyAction begin_action_list (string action, GLib.List<string> in_names, GLib.List<GLib.Value?> in_values, [CCode (scope = "async")] owned GUPnP.ServiceProxyActionCallback callback);
		public void cancel_action (GUPnP.ServiceProxyAction action);
		public bool end_action (GUPnP.ServiceProxyAction action, ...) throws GLib.Error;
		public bool end_action_hash (GUPnP.ServiceProxyAction action, [CCode (pos = -0.9)] GLib.HashTable<string,weak GLib.Value*> hash) throws GLib.Error;
		public bool end_action_list (GUPnP.ServiceProxyAction action, [CCode (pos = -0.9)] GLib.List<string> out_names, [CCode (pos = -0.8)] GLib.List<GLib.Type?> out_types, [CCode (pos = -0.7)] out GLib.List<weak GLib.Value*> out_values) throws GLib.Error;
		public bool get_subscribed ();
		public bool remove_notify (string variable, GUPnP.ServiceProxyNotifyCallback callback);
		public bool send_action (string action, ...) throws GLib.Error;
		public bool send_action_hash (string action, [CCode (pos = -0.9)] GLib.HashTable<string,GLib.Value?> in_hash, [CCode (pos = -0.8)] GLib.HashTable<string,weak GLib.Value*> out_hash) throws GLib.Error;
		public bool send_action_list (string action, [CCode (pos = -0.9)] GLib.List<string> in_names, [CCode (pos = -0.8)] GLib.List<weak GLib.Value?> in_values, [CCode (pos = -0.7)] GLib.List<string> out_names, [CCode (pos = -0.6)] GLib.List<GLib.Type?> out_types, [CCode (pos = -0.5)] out GLib.List<weak GLib.Value*> out_values) throws GLib.Error;
		public void set_subscribed (bool subscribed);
		public bool subscribed { get; set; }
		public virtual signal void subscription_lost (GLib.Error reason);
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h")]
	[Compact]
	public class ServiceProxyAction {
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gupnp_time_get_type ()")]
	[Compact]
	public class Time {
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gupnp_time_tz_get_type ()")]
	[Compact]
	public class TimeTZ {
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gupnp_uri_get_type ()")]
	[Compact]
	public class URI {
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gupnp_uuid_get_type ()")]
	[Compact]
	public class UUID {
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", type_id = "gupnp_white_list_get_type ()")]
	public class WhiteList : GLib.Object {
		[CCode (has_construct_function = false)]
		public WhiteList ();
		public bool add_entry (string entry);
		public void add_entryv ([CCode (array_length = false, array_null_terminated = true)] string[] entries);
		public bool check_context (GUPnP.Context context);
		public void clear ();
		public bool get_enabled ();
		public unowned GLib.List<string> get_entries ();
		public bool is_empty ();
		public bool remove_entry (string entry);
		public void set_enabled (bool enable);
		public bool enabled { get; set construct; }
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", type_id = "gupnp_xml_doc_get_type ()")]
	public class XMLDoc : GLib.Object {
		public weak Xml.Doc doc;
		[CCode (has_construct_function = false)]
		public XMLDoc (Xml.Doc xml_doc);
		[CCode (has_construct_function = false)]
		public XMLDoc.from_path (string path) throws GLib.Error;
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", has_type_id = false)]
	public struct ServiceActionArgInfo {
		public weak string name;
		public GUPnP.ServiceActionArgDirection direction;
		public weak string related_state_variable;
		public bool retval;
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", has_type_id = false)]
	public struct ServiceActionInfo {
		public weak string name;
		public weak GLib.List<GUPnP.ServiceActionArgInfo> arguments;
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", has_type_id = false)]
	public struct ServiceStateVariableInfo {
		public weak string name;
		public bool send_events;
		public bool is_numeric;
		public GLib.Type type;
		public GLib.Value default_value;
		public GLib.Value minimum;
		public GLib.Value maximum;
		public GLib.Value step;
		public weak GLib.List<string> allowed_values;
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", cprefix = "GUPNP_SERVICE_ACTION_ARG_DIRECTION_", has_type_id = false)]
	public enum ServiceActionArgDirection {
		IN,
		OUT
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", cprefix = "GUPNP_CONTROL_ERROR_")]
	public errordomain ControlError {
		INVALID_ACTION,
		INVALID_ARGS,
		OUT_OF_SYNC,
		ACTION_FAILED;
		public static GLib.Quark quark ();
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", cprefix = "GUPNP_EVENTING_ERROR_")]
	public errordomain EventingError {
		SUBSCRIPTION_FAILED,
		SUBSCRIPTION_LOST,
		NOTIFY_FAILED;
		public static GLib.Quark quark ();
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", cprefix = "GUPNP_SERVER_ERROR_")]
	public errordomain ServerError {
		INTERNAL_SERVER_ERROR,
		NOT_FOUND,
		NOT_IMPLEMENTED,
		INVALID_RESPONSE,
		INVALID_URL,
		OTHER;
		public static GLib.Quark quark ();
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", cprefix = "GUPNP_XML_ERROR_")]
	public errordomain XMLError {
		PARSE,
		NO_NODE,
		EMPTY_NODE,
		INVALID_ATTRIBUTE,
		OTHER;
		public static GLib.Quark quark ();
	}
	[CCode (cheader_filename = "libgupnp/gupnp.h", instance_pos = 3.9)]
	public delegate void ServiceIntrospectionCallback (GUPnP.ServiceInfo info, GUPnP.ServiceIntrospection introspection, GLib.Error error);
	[CCode (cheader_filename = "libgupnp/gupnp.h", instance_pos = 2.9)]
	public delegate void ServiceProxyActionCallback (GUPnP.ServiceProxy proxy, GUPnP.ServiceProxyAction action);
	[CCode (cheader_filename = "libgupnp/gupnp.h", instance_pos = 3.9)]
	public delegate void ServiceProxyNotifyCallback (GUPnP.ServiceProxy proxy, string variable, GLib.Value value);
}
