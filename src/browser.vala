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
public class RUI.MainWindow : RUI.BrowserWindow {
    private string home_uri;

    private RUI.Discoverer discoverer;
    private string? rui_json = null;

    public MainWindow(Soup.URI home, bool debug = false,
            bool start_fullscreen = false) {
        base(start_fullscreen);
        this.home_uri = home.to_string(false);
        this.discoverer = new RUI.Discoverer(debug);
        this.discoverer.services_changed.connect(services_changed);

        this.web_view.load_changed.connect(load_changed);
    }

    protected override void on_escape_key() {
        this.web_view.load_uri(home_uri);
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
