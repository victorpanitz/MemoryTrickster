@testable import MemoryTrickster

final class MemoryBufferInterfaceSpy: MemoryBufferInterface {
    var bufferToBeReturned: [[Int8]] = []
    var buffer: [[Int8]] { bufferToBeReturned }
    
    var sizeToBeReturned: Int = 0
    var size: Int { sizeToBeReturned }

    private(set) var addBytesPassed: Int?
    private(set) var addCalled: Bool = false
    func add(bytes: Int) {
        addBytesPassed = bytes
        addCalled = true
    }
    
    private(set) var removeBytesPassed: Int?
    private(set) var removeCalled: Bool = false
    func remove(bytes: Int) {
        removeBytesPassed = bytes
        removeCalled = true
    }
    
    private(set) var clearCalled: Bool = false
    func clear() {
        clearCalled = true
    }
}
