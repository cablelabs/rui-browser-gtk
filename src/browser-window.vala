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
public class RUI.BrowserWindow : Gtk.Window {
    private const string TITLE = "RUI Browser";

    public WebKit.WebView web_view { get; private set; }
    private bool is_fullscreen = false;

    public BrowserWindow(bool start_fullscreen = false) {
        set_default_size(800, 600);
        if (start_fullscreen) {
            fullscreen();
        }

        this.web_view = new WebKit.WebView();
        add(this.web_view);
        this.web_view.notify["title"].connect(() => {
            this.title = "%s - %s".printf(this.web_view.title, TITLE);
        });

        this.key_press_event.connect(on_key_pressed);
        this.window_state_event.connect(on_window_state_changed);
    }

    protected virtual void on_escape_key() {
        this.close();
    }

    private bool on_key_pressed(Gdk.EventKey key) {
        switch (key.keyval) {
        case Gdk.Key.Escape:
            on_escape_key();
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
}
