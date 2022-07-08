# ios_bucksapp_sdk

[![CI Status](https://img.shields.io/travis/Raul/ios_bucksapp_sdk.svg?style=flat)](https://travis-ci.org/Raul/ios_bucksapp_sdk)
[![Version](https://img.shields.io/cocoapods/v/ios_bucksapp_sdk.svg?style=flat)](https://cocoapods.org/pods/ios_bucksapp_sdk)
[![License](https://img.shields.io/cocoapods/l/ios_bucksapp_sdk.svg?style=flat)](https://cocoapods.org/pods/ios_bucksapp_sdk)
[![Platform](https://img.shields.io/cocoapods/p/ios_bucksapp_sdk.svg?style=flat)](https://cocoapods.org/pods/ios_bucksapp_sdk)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ios_bucksapp_sdk is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ios_bucksapp_sdk'
```

## Usage

For implement in your app simply instantiate the Bucksapp View Controller
```
        let vc = Bucksapp();
        vc.apiKey = "API_KEY";
        vc.uuid = "UUID";
        vc.environment = "sandbox";
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
```

## Author

Raul, raul@bucksapp.co

## License

ios_bucksapp_sdk is available under the MIT license. See the LICENSE file for more info.
