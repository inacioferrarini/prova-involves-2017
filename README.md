# Series Manager
[![Swift 3.1](https://img.shields.io/badge/Swift-3.1-green.svg?style=flat)](https://swift.org/)
[![License](https://img.shields.io/cocoapods/l/York.svg?style=flat)](http://cocoapods.org/pods/York)

This iOS App keeps track of your series though [Trakt.tv](http://docs.trakt.apiary.io/#).

In order to do so, a Trakt.tv User Account is required.

If you do not have a Trakt.tv User Account, you can create one at login moment, or you can [Join Trakt.tv](https://trakt.tv/auth/join).


# Capabilities
-- include app features here.


# Architecture
## Third Party Libraries Policy
Although there are some client libraries for Trakt.tv, like TraktKit and AKTrakt, but I've choose not to use them.
Besides poor compatibility with Swift 3, the usage of Alamofire, which is a huge and cumbertone library, that increases the final binary size and can be safely replaced by a far simpler and straighforward approach like urlsession's abstraction I made in Glasgow, what makes  Glasgow's Networking subspec API abstraction simpler and more suitable for this project.

## Cache
Cache is stored using Core Data, since other alternatives, like Realm or firebase would increase the final binary size. As data is synchronized through Trakt.tv api, this advantage Realm and Firebase would provide out of the box, is not needed.

# Tools
Tools used to support the development:
* Xcode 8.3.3
* Ruby - Necessary evil
* Paw - API Requests
* Charles Proxy - Http Debugger
* Bundler - Constraint Ruby Gems versions
* Cocoapods - Dependency Management

# Libraries
* Glasgow - Developed by me, provides basic foundation classes for common scenarios in iOS project.
* SnapKit - DSL for Autolayout abstraction for ViewCode ViewControllers.

# Requirements
This app is compatible with iOS 8.0+

Execute Cocoapods task through bundler.
```ruby
$ bundle exec pod install
```

A Rakefile was created to make easier to execute common daily activies.
```ruby
$ rake install
```