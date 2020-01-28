# DreamTeam Core iOS

## What?

This is the set of extensions, frames, sources and other things that could be useful in iOS app development.

This repository will be really helpful in MVVM architecture because it contains:

* `@Bindable` property wrapper
* `ButtonFrame`, `InputFrame`, and other frames – tiny view models – abstractions of UI controls
* Base and Bindable classes – boilerplates for your projects
* Router implementation

## How?

See the [ExampleApp](/examples/README.md) project for getting help with start working with this library.

The example includes some basic things:

* how to work with a collection and searching elements inside
* how to work with text fields and validation

## Requirements

* iOS 12.0+
* Xcode 10.2+
* Swift 5+

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but DT.Core.iOS does support its use on supported platforms.

Once you have your Swift package set up, adding DT.Core.iOS as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/DreamTeamMobile/dt-ios-core.git", .branch("master"))
]
```

### Cocoapods

```
pod 'DTCore'
pod 'DTCoreComponents'
```

## License

DT.Core.iOS is released under the MIT license. [See LICENSE](LICENSE) for details.
