## Dependencies

### Ubuntu 14.04

    sudo apt-get install git valac libgupnp-1.0-dev libgee-0.8-dev libjson-glib-dev libwebkitgtk3-devel

    # tup build tool
    # see: http://gittup.org/tup/
    sudo apt-add-repository 'deb http://ppa.launchpad.net/anatol/tup/ubuntu precise main'
    sudo apt-get update
    sudo apt-get install tup

### Fedora 20

    sudo yum install fuse-devel gupnp-devel libgee-devel vala

    # setup Tup
    git clone git://github.com/gittup/tup.git
    cd tup
    ./bootstrap.sh

    sudo ln -s $PWD/tup /usr/local/bin/tup
    cd ..

## Get Source

    git clone https://github.com/cablelabs/rui-browser-gtk.git
    cd rui-browser-gtk

## Build

    tup init
    tup upd

While developing, it can be useful to leave `tup` running in the background, autocompiling every time anything changes:

    tup monitor -a
    # stop with 'tup stop'

## Running

    ./src/browser --static-dir ./static

Run with `--fullscreen` to start fullscreen, or use F11 to toggle it while running. Use `--help` for other options.
