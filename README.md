# RUI Browser

[![Screencast](screencast-image.png)](http://youtu.be/POw81mfzgrk)

This is a web browser with RUI discovery built-in. Use the "Esc" key to return to the discovery page. F11 toggles fullscreen.

## Get Source

    git clone https://github.com/cablelabs/rui-browser-gtk.git --recursive
    cd rui-browser-gtk

## Build

In general, you should build with this script:

    ./build.sh

This will install dependencies and rebuild.

After dependencies are installed, you can also leave `tup` running in the background to recompile whenever any files change. This is generally only useful if you're making changes to the source code.

    tup monitor -a
    # stop with 'tup stop'

There is also a `clean.sh` script if you need it, but tup should usually handle that for you.

## Running

    src/browser --home static/index.html

Note that `--home` *must* point to the complete path to `static/index.html`. The command above will only work if you're in the root directory of the repo. Otherwise you'll need to put in the full command. For example, something like this:

    ~/workspace/rui-browser-gtk/src/browser --home ~/workspace/rui-browser-gtk/src/browser

At some point we'd like to use `GResource` for this, but we weren't able to get WebKit to load a `GResource`.

Run with `--fullscreen` to start fullscreen, or use F11 to toggle it while running. Use `--help` for other options.

## Using WebKitGTK+ From Git

The instructions above use your Linux distro's package manager to find WebKitGTK+. If you want to use a version from git (for subtitle and caption support, for example), then follow these instructions.

I haven't found a way to do this without installing WebKit. Do a **release** build of WebKit, then go into the build directory and run either `make install`, `ninja install` or `ninja-build install` (depending on if ninja is installed). For some reason this won't work with debug builds.

    cd ~/workspace/webkit
    # add gst-git to the next command if necessary
    Tools/Scripts/build-webkit --gtk
    cd WebKitBuild/Release

    # The install command depends on which build system is being used.
    # Most likely this is ninja:
    sudo ninja install

    # On Fedora ninja is named ninja-build
    sudo ninja-build

    # If ninja isn't installed, it will be be make
    sudo make install

Look at the command output and figure out where it installed the libraries too. There should be a bunch of lines about copying .so files to /usr/local/lib[something]. In our experience, this has been /usr/local/lib/x86_64-linux-gnu on Ubuntu 64-bit and /usr/local/lib64 on Fedora. Add that folder to your `LD_LIBRARY_PATH`:

    # Temp variable to make this documentation easier to write
    # Set this to the path described above ^
    export LOCAL_LIB_PATH=/usr/local/lib/path/to/libwebkit2gtk-3.0.so

Now set `LD_LIBRARY_PATH` and `PKG_CONFIG_PATH` based on that:

    export LD_LIBRARY_PATH="$LOCAL_LIB_PATH:$LD_LIBRARY_PATH"
    export PKG_CONFIG_PATH="$LOCAL_LIB_PATH/pkgconfig:$PKG_CONFIG_PATH"

You can add these to your .bashrc if you want it to be automatic from now on. Make sure to replace `$LOCAL_LIB_PATH` with the full path if you put it in your .bashrc, or include the `export LOCAL_LIB_PATH=...` line.

### Full Example

This assumes that WebKit's `ninja install` or `make install` put everything in /usr/local/lib/x86_64-linux-gnu, and that you're using `gst-git`.

    PKG_CONFIG_PATH=/usr/local/lib/x86_64-linux-gnu/pkgconfig ./build.sh
    LD_LIBRARY_PATH=/usr/local/lib/x86_64-linux-gnu gst-git ./src/browser --home static/index.html

## Customization

This browser has been designed to be customizable. If you want to change anything about the look and feel, just change any of the files in the "static" folder except for js/rui-discovery.js (this file is just a shim to provide a consistent interface).

For example, if you like the layout but don't like the color scheme (or need to make it fit your corporate branding guidelines), then just change css/styles.css. If you hate our page, create a new HTML page, include js/rui-discovery.js and then listen for:

    $(window.RUIDiscoverer).on("change", function yourcallback(event, ruis) {
        // ruis is a list of RemoteUIs in JSON format
    });

If you really need the raw XML, you can reimplementing rui-discoverer.js too, by defining this:

    window.RUIDiscoverer = {
        handleUIs: function(newUIs) {
            // newUIs is a list of services:
            // service = {
            //     id: /* Service's UDN */,
            //     base_url: /* Service's base URL */,
            //     ui_listing: /* Raw XML string containing <uilist> */
            // }
        }
    }
