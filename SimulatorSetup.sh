#!/bin/sh
#
# Setup Simulator accounts for testing
# by overwriting Simulator Library with contents of SimulatorLibraryOverride folder
#
# To update SimulatorLibraryOverride manually copy included subdirectories from simulator library folder
if [[ -d "$PROJECT_DIR" ]]
then
    echo "Overriding accounts in iPhone Simulator sandbox environment"
    for device in ~/Library/Developer/CoreSimulator/Devices/*/device.plist; do
        runtime=$(defaults read "${device}" runtime)
        devicedir="$(dirname ${device})"
        libdir="$devicedir/data/Library"
        if [[ $runtime = com.apple.CoreSimulator.SimRuntime.iOS-8* ]]
        then
            echo "Overriding iOS8 accounts in:$libdir"
            cp -vfR "$PROJECT_DIR/Acceptance Tests/SimulatorLibraryOverride8"/* "$libdir"/
        fi
    done
else
    echo "PROJECT_DIR is not defined to find override files"
    exit 1
fi
