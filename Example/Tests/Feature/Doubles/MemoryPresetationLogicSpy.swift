@testable import MemoryTrickster

final class MemoryPresetationLogicSpy: MemoryPresetationLogic {
    private(set) var memoryPassed: Memory?
    private(set) var didGetMemoryReportWithSuccessCalled: Bool = false
    func didGetMemoryReportWithSuccess(with memory: Memory) {
        didGetMemoryReportWithSuccessCalled = true
        memoryPassed = memory
    }
    
    private(set) var errorPassed: Error?
    private(set) var didGetMemoryReportWithErrorCalled: Bool = false
    func didGetMemoryReportWithError(_ error: Error) {
        didGetMemoryReportWithErrorCalled = true
        errorPassed = error
    }
}
