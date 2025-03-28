[![CI](https://github.com/LibVNC/macVNC/actions/workflows/ci.yml/badge.svg)](https://github.com/LibVNC/macVNC/actions/workflows/ci.yml)

# About

macVNC is a simple command-line VNC server for macOS.

It is [based on the macOS server example from LibVNCServer](https://github.com/LibVNC/libvncserver/commits/6e5f96e3ea53bf85cec7d985b120daf1c91ce0d9/examples/mac.c?browsing_rename_history=true&new_path=examples/server/mac.c&original_branch=master)
which in turn is based on OSXvnc by Dan McGuirk which again is based on the original VNC
GPL dump by AT&T Cambridge.

## Features

* Fully multi-threaded.
* Double-buffering for framebuffer updates.
* Mouse and keyboard input.
* Multi-monitor support.

# Building

You'll need LibVNCServer for building macVNC; the easiest way of installing this is via a package manager:
If using Homebrew, you can install via `brew install libvncserver`; if using MacPorts, use `sudo port
install LibVNCServer`.

macVNC uses CMake, thus after installing build dependencies it's:

    mkdir build
    cd build
    cmake ..
    cmake --build .
    cmake --install .

# Running

As you might have Apple's Remote Desktop Server already running (which occupies port 5900),
you can run macVNC via

    ./macVNC.app/Contents/MacOS/macVNC -rfbport 5901

In its default setup, macVNC does mouse and keyboard input. For this, it needs certain system permissions.
It tells you on first run if these are missing; you can set up permissions via 'System Preferences'->'Security & Privacy'->'Privacy'->'Accessibility'.
Note that if launched from Terminal, the entry shown will be 'Terminal', not 'macVNC'.

Note that setting a password is mandatory in case you want to access the server using MacOS's built-in Screen Sharing app.
You can do so via the `-passwd` commandline argument.

# License

As its predecessors, macVNC is licensed under the GPL version 2. See [COPYING](COPYING) for more information.




