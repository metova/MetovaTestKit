# Metova Test Kit CHANGELOG

## Unpublished

- Added convenience method for testing UICollectionViewCells
- Added convenience method for testing UITableViewCells

## 2.1.0

- Converted to Swift 4.2

## 2.0.0

- Converted to Swift 4.0

## 1.2.0

- Deprecate `MTKWaitThenContinueTest(after:on:testAction:)` in favor of `MTKWaitThenContinueTest(after:)`. This addresses issue [#24](https://github.com/metova/MetovaTestKit/issues/24).

## 1.1.0

- Added assertion for UIControl target/action.
- Added assertion for UISegmentedControl segment titles.
- Added async testing utility.
- Added assertion for displaying UIAlertControllers.
- Added assertion for UIBarButtonItem target/action.

## 1.0.0

- Converted to Swift 3.0.

## 0.2.2

- Resolved issue regarding testing functions that cause tests to fail.
- Removed empty-first-line rule from .swiftlint.yml.

## 0.2.1

- Updating gemfile

## 0.2.0

- Added `MTKAssertNoBrokenConstraints`

## 0.1.7

- Fixed problem with Travis buildscript

## 0.1.6

- Removed `MTKCatchException` from public scope.
- Exception assertions will now return the exception they caught which caused them to pass/fail.

## 0.1.5

- Expanding code coverage

## 0.1.4

- Fixed links in CONTRIBUTING.md
- Added slather gem for code coverage reporting via Coveralls
- Code coverage reporting is working now

## 0.1.3

- Fixing CocoaPods README badges.
- Adding .travis.yml
- Travis-CI is now running.

## 0.1.2

- Updating README.

## 0.1.1

- Fixed podspec.

## 0.1.0

- Initial release.
