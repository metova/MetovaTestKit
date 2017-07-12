-----

### What Is This "Hostedtests" Target For?

When creating a test target for testing a framework, you will usually want to select the framework for the "Target to be Tested" field. This is how the "MetovaTestKitTests" target is set up. However, MetovaTestKit has some features that can only be tested within the context of a UIKit app. 

### MetovaTestKit Components Tested by "HostedTests"

| Component                                                    | Why It Must Be Tested in the Context of a Host Application                                                                                                                                                                                                                                                      |
|--------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `MTKAssertAlertIsPresented(by:style:title:message:actions:)` | This assertion checks to see if a view controller has presented a particular alert. A view controller can only present another view controller if it is added to the window. The "HostApplicationForTesting" target provides the window in which our test view controller can present alerts in the test suite. |

-----
