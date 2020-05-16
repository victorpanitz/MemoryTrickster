![Banner](/resources/banner.png)

# Memory Trickster

Build Status codecov Version License Platform

![Accuracy](/resources/memTAccuracy.gif)

## What's Memory Trickster?

Memory Trickster is a tool which enables you controlling the memory usage of your device. The point here is not to get limited to a memory warning but indeed fill the memory with fake content achieving real world scenarios (famous corner cases).

## Example

To run the example project, clone the repo, and run pod install from the Example directory first.

## Installation

MemoryTrickster is available through CocoaPods. To install it, simply add the following line to your Podfile:

```Swift
pod 'MemoryTrickster'
```

## Usage

It's really simple to get start with Memory Trickster. After the instalation, you just need to import Memory Trickster and run it.

```Swift
MemoryOrchestrator.shared.run()
```

The tool acts continuosly tracking the top view controller and keeping the itself over it.
If you want to customize the pooling timer, you can also instantiate the orchestrator using the factory,

```Swift
let orchestrator = MemoryTricksterFactory.makeOrchestrator(with: 0.5)
orchestrator.run()
```

With the tool on, you still have some hide quick actions.

Pressing the green injected view, you'll get a dialog providing you the possibility to clear the memory buffer and close the tool as well.

We're currently supporting all iPhone sizes and orientations

![Sizes](/resources/deviceSizes.png)
![Orientation](/resources/gestureMT.gif)

## Do not want to use the UI?

If you want to build automated tests, or something which fits better to your context, you would like to play with the memory bridge interface

```Swift
public typealias MemoryResult = Result<Memory, MemoryError>

public struct Memory {
    public let remaining: Int64
    public let used: Int64
    public let injected: Int64
}

public protocol MemoryBridgeInterface {
    func getMemoryDetails(completion: (MemoryResult) -> ())
    func injectBytes(_ bytes: Int)
    func removeBytes(_ bytes: Int)
    func clearMemory()
}
```

To get a memory bridge instance, just use

```Swift
let memoryBridge = MemoryTricksterFactory.makeMemoryBridge()
```

## Contributors

The tool is a current v0, a lot to improve and needed work in order to achieve a great result, all contributions are welcome 🙏

🇧🇷 - Victor Panitz Magalhães

## License

MemoryTrickster is available under the MIT license. See the LICENSE file for more info.
