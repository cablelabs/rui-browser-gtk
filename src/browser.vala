/* Copyright (c) 2014, CableLabs, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */
public class RUI.Browser : Gtk.Window {
    private const string TITLE = "RUI Browser";
    private string home_uri;

    private WebKit.WebView web_view;
    private RUI.Discoverer discoverer;
    private string? rui_json = null;
    private bool is_fullscreen = false;

    public Browser(Soup.URI home, bool debug = false,
            bool start_fullscreen = false) {
        this.home_uri = home.to_string(false);
        set_default_size(800, 600);
        if (start_fullscreen) {
            fullscreen();
        }
        this.discoverer = new RUI.Discoverer(debug);
        this.discoverer.services_changed.connect(services_changed);

        WebKit.Settings settings = new WebKit.Settings();
        settings.enable_mediasource = true;
        this.web_view = new WebKit.WebView.with_settings(settings);
        add(this.web_view);
        this.web_view.notify["title"].connect(() => {
            this.title = "%s - %s".printf(this.web_view.title, TITLE);
        });
        this.web_view.load_changed.connect(load_changed);

        this.key_press_event.connect(on_key_pressed);
        this.window_state_event.connect(on_window_state_changed);
    }

    private bool on_key_pressed(Gdk.EventKey key) {
        switch (key.keyval) {
        case Gdk.Key.Escape:
            this.web_view.load_uri(home_uri);
            break;
        case Gdk.Key.F11:
            if (is_fullscreen) {
                unfullscreen();
            } else {
                fullscreen();
            }
            break;
        default:
            return false;
        }
        return true;
    }

    private bool on_window_state_changed(Gdk.EventWindowState event) {
        this.is_fullscreen = Gdk.WindowState.FULLSCREEN in event.new_window_state;
        return false;
    }

    private void load_changed(WebKit.WebView web_view,
            WebKit.LoadEvent load_event) {
        if (load_event != WebKit.LoadEvent.FINISHED) {
            return;
        }
        update_ruis.begin();
    }

    private void services_changed() {
        Json.Builder builder = new Json.Builder();
        builder.begin_array();
        foreach (var service in discoverer.services) {
            builder.begin_object();
            builder.set_member_name("id");
            builder.add_string_value(service.id);
            builder.set_member_name("ui_listing");
            builder.add_string_value(service.ui_listing);
            builder.set_member_name("base_url");
            builder.add_string_value(service.base_url);
            builder.end_object();
        }
        builder.end_array();

        Json.Generator generator = new Json.Generator();
        generator.set_pretty(true);
        generator.set_root(builder.get_root());
        rui_json = generator.to_data(null);

        update_ruis.begin();
    }

    private async void update_ruis() {
        if (this.web_view.uri != home_uri || rui_json == null) {
            return;
        }
        try {
            yield this.web_view.run_javascript("window.RUIDiscoverer.handleUIs(%s);".printf(rui_json), null);
        } catch (Error e) {
            stdout.printf("Unable to inject RUIs: %s\n", e.message);
        }
    }

    public void start(string? url) throws Error {
        discoverer.start();

        show_all();
        if (url != null) {
            this.web_view.load_uri(url);
        } else {
            this.web_view.load_uri(home_uri);
        }
    }
}
