import os.log

protocol MemoryPresetationLogic: AnyObject {
    func didGetMemoryReportWithSuccess(with memory: Memory)
    func didGetMemoryReportWithError(_ error: Error)
}

final class MemoryPresenter {
    var view: MemoryDisplayLogic?
    var orchestrator: MemoryOrchestratableInput
    
    init(orchestrator: MemoryOrchestratableInput) {
        self.orchestrator = orchestrator
    }
    
    func memoryModificationTriggered(with modifier: MemoryModifier) {
        orchestrator.handleMemoryModification(with: modifier)
    }
    
    func clearMemoryTriggered() {
        orchestrator.clearMemory()
    }
    
    func stopMemoryTrickster() {
        orchestrator.clearMemory()
        orchestrator.unplugTimer()
    }
}

extension MemoryPresenter: MemoryPresetationLogic {
    func didGetMemoryReportWithSuccess(with memory: Memory) {
        view?.updateRemainingMemory(with: memory.remaining.toMemoryUnity())
        view?.updateUsedMemory(with: memory.used.toMemoryUnity())
        view?.updateInjectedMemory(with: memory.injected.toMemoryUnity())
        view?.updateViewVisibility()
    }

    func didGetMemoryReportWithError(_ error: Error) {
        os_log("%{public}@", error.localizedDescription)
    }
}
