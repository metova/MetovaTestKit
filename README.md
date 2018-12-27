[![MetovaTestKit](https://github.com/metova/MetovaTestKit/blob/master/Assets/MetovaTestKit.png?raw=true)](https://cocoapods.org/pods/MetovaTestKit)

<p align="center">
 <a href="https://travis-ci.org/metova/MetovaTestKit" target="_blank"><img src="https://travis-ci.org/metova/MetovaTestKit.svg?branch=master" alt="Build Status"></a> 
 <a href="https://cocoapods.org/pods/MetovaTestKit" target="_blank"><img src="https://img.shields.io/cocoapods/v/MetovaTestKit.svg" alt="CocoaPods Compatible"/></a>
 <a href="http://metova.github.io/MetovaTestKit/" target="_blank"><img src="https://cdn.rawgit.com/metova/MetovaTestKit/master/docs/badge.svg" alt="Documentation"/></a>
 <a href="https://coveralls.io/github/metova/MetovaTestKit?branch=master" target="_blank"><img src="https://coveralls.io/repos/github/metova/MetovaTestKit/badge.svg?branch=master&dummy=no_cache_please_1" alt="Coverage Status"/></a>
 <a href="http://cocoadocs.org/docsets/MetovaTestKit" target="_blank"><img src="https://img.shields.io/cocoapods/p/MetovaTestKit.svg?style=flat" alt="Platform"/></a>
 <a href="http://twitter.com/metova" target="_blank"><img src="https://img.shields.io/badge/twitter-@Metova-3CAC84.svg" alt="Twitter"/></a>
 <br/>
</p>
 
MetovaTestKit is a collection of useful test helpers designed to ease the burden of writing tests for iOS applications.

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
    - [MTKTestable Protocol](#mtktestable)
    - [Testing UIKit Components](#testing-uikit-components)
        - [UIAlertController](#uialertcontroller)
        - [UIBarButtonItem](#uibarbuttonitem)
        - [UIControl](#uicontrol)
        - [UICollectionViewCell](#uicollectionviewcell)
        - [UITableViewCell](#uitableviewcell)
        - [UISegmentedControl](#uisegmentedcontrol)
    - [Testing Dates](#testing-dates)
    - [Testing Auto Layout Constraints](#testing-auto-layout-constraints)
    - [Testing Exceptions](#testing-exceptions)
    - [Asynchronous Testing](#asynchronous-testing)
- [Documentation](#documentation)
- [Credits](#credits)
- [License](#license)

-----

# Requirements

- Swift 4.0
- iOS 9+

-----

# Installation

MetovaTestKit is available through [CocoaPods](http://cocoapods.org).

MetovaTestKit is intended to be used with unit testing targets. To install it, add MetovaTestKit your project's Podfile:

```ruby
target 'YourApp' do
  # Your app's pods:
  pod 'DataManager'
  pod 'ThunderCats'
  pod 'MetovaBase'

  target 'YourAppTests' do
    inherit! :search_paths
    pod 'MetovaTestKit'
  end
end
```

And run `pod install`

If you would like to test a beta version of MetovaTestKit, you can install the latest from develop:

```ruby
pod 'MetovaTestKit', :git => 'https://github.com/metova/MetovaTestKit.git', :branch => 'develop'
```

-----

# Usage

## MTKTestable

MetovaTestKit defines the `MTKTestable` protocol. Correct implementation of this protocol allows for functional unit testing. It abstracts away the set up and tear down code into extensions of the types you want to test, and allows for functional unit tests.

```swift
func testOutlets() {
    HomeViewControllerClass.test { testVC in
        XCTAssertNotNil(testVC.userameTextField)
        XCTAssertNotNil(testVC.passwordTextField)
        XCTAssertNotNil(testVC.loginButton)
    }
}
```

The `test` function rethrows any errors thrown inside the `testBlock`, allowing you to leveraging `throw`ing test cases to more conveniently denote failures.

```swift
func testLogin() throws {
    try HomeViewControllerClass.test { testVC in
        try testVC.login(username: "jimmythecorgi", password: "woofwoof123")
    }
}
```

## Testing UIKit Components


### UIAlertController

Verify that a view controller presented an alert having a particular style, title, message, and actions.

```swift
MTKAssertAlertIsPresented(
    by: testVC,
    style: .alert,
    title: "Warning",
    message: "Are you sure you want to delete this user?",
    actions: [
        ExpectedAlertAction(title: "Delete", style: .destructive),
        ExpectedAlertAction(title: "Cancel", style: .cancel)
    ]
)
```

### UIBarButtonItem

Verify that a bar button item has the expected target/action pair and that the target actually responds to the selector that will be sent to it. 

```swift
MTKAssertBarButtonItem(testVC.editBarButtonItem, sends: #selector(MyViewController.didTapEditButton(_:)), to: testVC) 
```

### UIControl

With a single assertion, you can verify that your control actions are hooked up and that your target actually responds to the selector that will be sent to it. 

```swift
MTKAssertControl(testVC.loginButton, sends: #selector(LoginViewController.didTapLoginButton(_:)), to: testVC, for: .touchUpInside, "The login button should be hooked up to the login action.") 
```


### UICollectionViewCell

Assert that a collection view returns a cell of a specific type for a given index path.  Pass a block of code to perform additional tests on the cell, if it exists.

```swift
MTKTestCell(in: tableView, at: indexPath, as: MyCollectionViewCell.self) { testCell in 
    XCTAssertEqual(testCell.label.text, "Hello World!")
}
```

See [the tests](./MetovaTestKitTests/CellTestingTests/MTKCollectionViewTestCellTests.swift#L34) for examples of test failures this method can generate.

### UITableViewCell

Assert that a table view returns a cell of a specific type for a given index path.  Pass a block of code to perform additional tests on the cell, if it exists.

```swift
MTKTestCell(in: tableView, at: indexPath, as: MyTableViewCell.self) { testCell in
    XCTAssertEqual(testCell.label.text, "Hello World!")
}
```

See [the tests](./MetovaTestKitTests/CellTestingTests/MTKTableViewTestCellTests.swift#L34) for examples of test failures this method can generate.

### UISegmentedControl
 
Verify that a `UISegmentedControl` has the segment titles you are expecting. 
 
```swift
MTKAssertSegmentedControl(segmentedControl, hasSegmentTitles: ["Followers", "Following"])
```
 
## Testing Dates
 
You can use MetovaTestKit to assert two dates are equal when only considering specified components.

```swift
MTKAssertEqualDates(date1, date2, comparing: .year, .month, .day)
```

This assertion accepts components as a variadic argument or as a `Set<Calendar.Component>`.

```swift
let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
MTKAssertEqualDates(date1, date2, comparing: components)
MTKAssertEqualDates(date3, date4, comparing: components)
MTKAssertEqualDates(date5, date6, comparing: components)
```
 
## Testing Auto Layout Constraints

You can use MetovaTestKit to assert that you do not have broken Auto Layout constraints.

```swift
MTKAssertNoBrokenConstraints {
    // code that does anything that impacts the user interface
    // including simply loading a view for the first time
}
```

This assertion will fail for any broken constraints and report the number of constraints that broke during the test. You can also pass a custom message.

```swift
MTKAssertNoBrokenConstraints(message: "Constraints were broken.") {
    // code to test
}
```

This test also returns a value with a count of the number of constraints broken.

```swift
let brokenConstraintCount = MTKAssertNoBrokenConstraints {
    // code to test
}
```

## Testing Exceptions

You can use MetovaTestKit to assert that code that should not throw exceptions doesn't. Without MetovaTestKit, this would result in the entire test suite crashing. With MetovaTestKit, this is just a failed test, and you still get to run the rest of the test suite.

```swift
MTKAssertNoException {
    // code that should not throw exceptions
    // results in passing test if no exceptions are thrown
    // results in failing test if exceptions are thrown
}
```

You can also pass a message to print on failure.

```swift
MTKAssertNoException(message: "Exception was thrown.") {
    // code that should not throw exceptions
    // results in passing test if no exceptions are thrown
    // results in failing test if exceptions are thrown
}
```

You can also test code to verify that exceptions are thrown, and can do this without crashing your test suite. If you do not care about the specific exception but only want to verify that the code block throws an exception, you can use `MTKAssertException`:

```swift
MTKAssertException {
    // code that should throw exceptions
    // results in passing test if an exception is thrown
    // results in a failing test if this closure returns without throwing
}
```

Like `MTKAssertNoException`, this function also accepts a message:

```swift
MTKAssertException(message: "No exception was thrown.") {
    // code that should throw exceptions
    // results in passing test if an exception is thrown
    // results in a failing test if this closure returns without throwing
}
```

These methods do return the thrown exception in case you need more information about it.

```swift
guard let exception = MTKAssertException(testBlock: throwingBlock) else {
    XCTFail("Block failed to throw an exception")
    return
}

// More assertion about the given exception that was returned
```

```swift
if let exception = MTKAssertNoException(testBlock: blockThatShouldntThrow) {
    XCTFail("Block should not have thrown but instead threw \(exception)")
    return
}
```

If the closure did not throw an exception, the function returns `nil`. Otherwise, it returns an instance of `NSException` which you can verify is the exception you expected your block to throw.

 
## Asynchronous Testing
 
XCTest provides asynchronous testing capabilities using `expectation(description:)` and `waitForExpectations(timeout:handler:)`. However, when testing simple delayed asynchronous actions, this approach can be cumbersome and the intent might not be immediately obvious. Using MetovaTestKit's `MTKWaitThenContinueTest(after:)` utility method, these kinds of tests become simple and they read naturally.
 
```swift
mockUserSearchNetworkRequest(withResponseTime: 0.5)
testViewController.didTapSearchButton()
 
XCTAssertFalse(testViewController.searchButton.isEnabled, "The search button should be disabled while a search request is taking place.")
 
MTKWaitThenContinueTest(after: 1)
 
XCTAssertTrue(testViewController.searchButton.isEnabled, "Once the request is complete, the search button should be re-enabled.") 
```
 
-----

# Documentation

Documentation can be found [here](http://metova.github.io/MetovaTestKit/).
 
-----

# Credits

MetovaTestKit is owned and maintained by [Metova Inc.](https://metova.com)

[Contributors](https://github.com/Metova/MetovaTestKit/graphs/contributors)

If you would like to contribute to MetovaTestKit, see our [CONTRIBUTING](CONTRIBUTING.md) guidelines.

MetovaTestKit banner image and other assets provided by Christi Johnson.

-----

# License

MetovaTestKit is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
