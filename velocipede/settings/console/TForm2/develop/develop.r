#!/usr/bin/r

# Is the Current Graphics Device Interactive?

# Description
# Test if the current graphics device (or that which would be opened) is interactive.

# Usage
# dev.interactive(orNone = FALSE)

# deviceIsInteractive(name = NULL)
# Arguments
# orNone	
# logical; if TRUE, the function also returns TRUE when .Device == "null device" and getOption("device") is among the known interactive devices.

# name	
# one or more device names as a character vector, or NULL to give the existing list.

# Details
# The X11 (Unix), windows (Windows) and quartz (macOS, on-screen types only) are regarded as interactive, together with JavaGD (from the package of the same name) and CairoWin and CairoX11 (from package Cairo). Packages can add their devices to the list by calling deviceIsInteractive.

# Value
# dev.interactive() returns a logical, TRUE if and only if an interactive (screen) device is in use.

# deviceIsInteractive returns the updated list of known interactive devices, invisibly unless name = NULL.

# See Also
# Devices for the available devices on your platform.

# Examples

dev.interactive()
print(deviceIsInteractive(NULL))