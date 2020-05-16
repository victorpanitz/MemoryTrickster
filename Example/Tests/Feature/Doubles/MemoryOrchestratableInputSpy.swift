@testable import MemoryTrickster

final class MemoryOrchestratableInputSpy: MemoryOrchestratableInput {
    private(set) var clearMemoryCalled: Bool = false
    func clearMemory() {
        clearMemoryCalled = true
    }
    
    private(set) var unplugTimerCalled: Bool = false
    func unplugTimer() {
        unplugTimerCalled = true
    }
    
    private(set) var modifierPassed: MemoryModifier?
    private(set) var handleMemoryModificationCalled: Bool = false
    func handleMemoryModification(with modifier: MemoryModifier) {
        handleMemoryModificationCalled = true
        modifierPassed = modifier
    }
}
