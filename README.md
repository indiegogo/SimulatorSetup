# SimulatorSetup
Setup your iOS simulator permissions from previous snapshots 

'SimulatorSetup' is a script which allows you to apply a previously captured simulator state to your iOS simulator prior to running your tests. This allows you to run tests which would otherwise require manual simulator setup prior to running the tests.

SimulatorSetup has been able to capture and restore the following simulator states:
 - Settings.app Facebook Account information 
 - Permissions to access Photos, and Contacts
 - Dismissal of the Keyboard emoji information notice

Appears to be broken in iOS8.4+ (for now)
- User Notification permissions (required to show remote or local notifications to the user)
 

'SimulatorSetup' currently supports iOS8.*, but is expected to work on iOS9 with minor modification.

# Setup Guide

## Overview

You use SimulatorSetup as follows: 

1. Manually setting up your simulator in the state you want to capture 
 1. i.e. with the states you want to capture setup (permissions given, Facebook account logged in in Settings.app etc)
1. Take an iOS simulator snapshot by manually copying and storing simulator internal folder structure
1. Store the snapshot folder structure with in your project with your tests
1. Configuring Xcode to restore this simulator snapshot before you run your Acceptance Tests (or Unit Tests run as Application tests)

## 1. Setup your simulator state
1. Run your application in the simulator
1. Perform the require app and simulator steps to setup your simulator state as you want it to be snapshotted.
1. Background your app
1. Exit the simulator (important to ensure all state written to disk)

## 2. Take a snapshot of your iOS simulator
1. In Finder, navigate to ```~/Library/Developer/CoreSimulator/Devices/```
1. Open most recently modified folder, like `2D723676-AFDD-4AF1-91C4-3F2774318F2A`
1. Confirm iOS version in device.plist matches your expectation
1. Select and copy the following folders from ```data/Library```:
 * ```Accounts```
 * `BackBoard`
 * ```DataAccess```
 * ```IdentityServices```
 * ```Keychains```
 * ```Passes```
 * ```TCC```
1. In Finder, navigate to your projects folder
1. Create a folder in your project root ($PROJECT_ROOT) called `SimulatorLibraryOverride8`
1. Paste folders into your newly created `SimulatorLibraryOverride8` folder. 

Note: Storing `SimulatorLibraryOverride8` elsewhere will require editing of `SetupSimulator.sh`

## Test Setup in Xcode

1. Copy SetupSimulator.sh into your project (these instructions will assume the folder is located in your $PROJECT_ROOT)
1. Edit your Xcode scheme which runs your tests
<br/>
<img src="https://raw.githubusercontent.com/IndieGoGo/SimulatorSetup/master/images/1_EditScheme.png" alt="Edit your Xcode scheme which runs your tests" width="200"/>
1. Select 'Test from the left column
1. Click the arrow '>' to expand out the sub-elements of 'Test'
<br/>
<img src="https://raw.githubusercontent.com/IndieGoGo/SimulatorSetup/master/images/2_Test%2BExpand.png" alt="Select 'Test from the left column and Click the arrow to expand out the sub-elements of Test" width="200"/>
1. Click on 'Pre-actions', then press the plus button '+' then select 'New Run Script Action'
<br/>
<img src="https://raw.githubusercontent.com/IndieGoGo/SimulatorSetup/master/images/3_AddScript.png" alt="Click on Pre-actions, then press the plus button then select New Run Script Action" width="200"/>
1. Replace `Type a script or drag a script file from your workspace to insert its path` with  `"$PROJECT_DIR/SetupSimulator.sh"` ![Replace `Type a script or drag a script file from your workspace to insert its path` with  `"$PROJECT_DIR/SetupSimulator.sh"`](https://raw.githubusercontent.com/IndieGoGo/SimulatorSetup/master/images/4_ScriptConfigured.png)
1. Press close

# All done!

Now when you build and run your tests, prior to their execution your simulator will be configured using your snapshot. 

# Important Note
This snapshot and setup is done from a blackbox perspective without knowledge or understanding of internal iOS simulator operation. As a result there is a chance it could cause your simulator to get into a broken state. Although typically the any issues can be recovered via a simulator reset, or Xcode re-install, please remember this code is provided as is without warrantee ([See License for full details](https://github.com/IndieGoGo/SimulatorSetup/blob/master/LICENSE))

# Contributions

Paul Zabelin (https://github.com/paulz) 
