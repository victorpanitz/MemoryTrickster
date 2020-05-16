import XCTest

@testable import MemoryTrickster

final class MemoryBridgeInterfaceSpy: MemoryBridgeInterface {
    private let expectation: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    private(set) var clearMemoryCalled: Bool = false
    func clearMemory() {
        clearMemoryCalled = true
    }
    
    private(set) var getMemoryDetailsCalled: Bool = false
    var memoryResultToBeReturned: MemoryResult = .failure(.memoryOffset)
    func getMemoryDetails(completion: (MemoryResult) -> ()) {
        getMemoryDetailsCalled = true
        completion(memoryResultToBeReturned)
        expectation.fulfill()
    }
    
    private(set) var injectBytesCalled: Bool = false
    func injectBytes(_ bytes: Int) {
        injectBytesCalled = true
    }
    
    private(set) var removeBytesCalled: Bool = false
    func removeBytes(_ bytes: Int) {
        removeBytesCalled = true
    }
}
