@testable import MemoryTrickster

final class MemoryDisplayLogicSpy: MemoryDisplayLogic {
    private(set) var updateRemainingMemoryPassed: String?
    private(set) var updateRemainingMemoryCalled: Bool = false
    func updateRemainingMemory(with memory: String) {
        updateRemainingMemoryPassed = memory
        updateRemainingMemoryCalled = true
    }
    
    private(set) var updateUsedMemoryPassed: String?
    private(set) var updateUsedMemoryCalled: Bool = false
    func updateUsedMemory(with memory: String) {
        updateUsedMemoryPassed = memory
        updateUsedMemoryCalled = true
    }
    
    private(set) var updateInjectedMemoryPassed: String?
    private(set) var updateInjectedMemoryCalled: Bool = false
    func updateInjectedMemory(with memory: String) {
        updateInjectedMemoryPassed = memory
        updateInjectedMemoryCalled = true
    }
    
    private(set) var updateViewVisibilityCalled: Bool = false
    func updateViewVisibility() {
        updateViewVisibilityCalled = true
    }
}
