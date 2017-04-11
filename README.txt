Mac OS X 10.9.5 (and possibly later) binary compatibility patch for Apple AirPort Utility 5.6.1

Apple dropped support for early AirPort Express devices in AirPort Utility 6.x and later, and AirPort Utility 5.6.1 does not run on later releases of OS X without modification.

# Changes

- Fixed references to missing non-lazy symbols in Apple80211; which was triggering a dyld abort() on launch:
  - Moved Apple80211 BIND_OPCODE_* statements from the strongly bound dyld opcode stream to the weakly bound opcode stream.
  - Adjusted the LC_DYLD_INFO command to account for moving the Apple80211 symbols; this required adjusting bind_(off|size) and weak_bind_(off|size) values.
- Patched -applicationDidFinishLaunching to skip the software update check; Apple returns update information for AirPort Utility 6.x, and the whole point is to use AirPort Utility 5.x.
- Removed PPC and i386 support. I didn't want to deal with patching multiple binaries, and if you have a PPC or i386-only machine, you can run the application without any patches.
- Inserted a LC_LOAD_DYLIB load command for CoreWLAN
- Rewrote the dylib lazy binding opcodes to substitute CoreWLAN's CWKeychainSetPassword/CWKeychainCopyPassword/CWKeychainDeletePassword for the previous references to Apple80211's (no longer available) ACNetworkSetKeychainPassword/ACNetworkCopyKeychainPassword/ACNetworkDeleteKeychainPassword.

