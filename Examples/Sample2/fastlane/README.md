fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios certificates

```sh
[bundle exec] fastlane ios certificates
```

Get certificates

### ios setup_keychain

```sh
[bundle exec] fastlane ios setup_keychain
```

Setup keychain and certificate

### ios download_provision_profiles

```sh
[bundle exec] fastlane ios download_provision_profiles
```

Download provision profiles using App Store Connect API 

### ios setup_delete_keychain

```sh
[bundle exec] fastlane ios setup_delete_keychain
```

Delete keychain

### ios build

```sh
[bundle exec] fastlane ios build
```

Build

### ios build_framework

```sh
[bundle exec] fastlane ios build_framework
```

Build Framework

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
