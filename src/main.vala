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

// TODO: Figure out why shutting down nicely causes a core dump in GUPnP.
extern void exit(int exit_code);

static bool debug = false;
static bool start_fullscreen = false;
static string? static_dir_path = null;

static const OptionEntry[] OPTIONS = {
    { "debug", 'd', 0, OptionArg.NONE, ref debug,
        "Print debug messages to the console", null },
    { "fullscreen", 'f', 0, OptionArg.NONE, ref start_fullscreen,
        "Start fullscreen (use F11 to toggle while running)", null },
    { "static-dir", 's', 0, OptionArg.FILENAME, ref static_dir_path,
        "The location of the static files (the \"static\" folder in the git repo)", null },
    { null }
};

int main(string[] args) {
    Gtk.init(ref args);

    string? url = null;
    File home;
    try {
        var opt_context = new OptionContext("RUI Browser");
        opt_context.set_help_enabled (true);
        opt_context.add_main_entries (OPTIONS, null);
        opt_context.parse (ref args);
        if (static_dir_path == null) {
            throw new OptionError.BAD_VALUE("--static-dir must be set");
        }
        var static_dir = File.new_for_path(static_dir_path);
        home = static_dir.get_child("index.html");
        if (!home.query_exists()) {
            throw new OptionError.BAD_VALUE(
                "--static-dir set incorrectly, %s does not exist".printf(
                home.get_path()));
        }
        if (args.length >= 2) {
            url = args[1];
        }
    } catch (OptionError e) {
        stderr.printf ("%s\n", e.message);
        stderr.printf ("Run '%s --help' to see a full list of available command line options.\n",
            args[0]);
        return 2;
    }

    RUI.Browser browser = new RUI.Browser(home, debug, start_fullscreen);
    browser.destroy.connect(() => {
        exit(0);
    });
    try {
        browser.start(url);
    } catch (Error e) {
        stderr.printf("Error starting browser: %s\n", e.message);
        return 1;
    }

    Gtk.main();
    return 0;
}
