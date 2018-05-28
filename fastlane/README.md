fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios debug
```
fastlane ios debug
```
Push a new debug build to the pgyer
### ios release
```
fastlane ios release
```
Push a new release build to the pgyer
### ios testflight
```
fastlane ios testflight
```
Push a new build to the TestFlight
### ios appstore
```
fastlane ios appstore
```
Push a new build to the AppStore

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
