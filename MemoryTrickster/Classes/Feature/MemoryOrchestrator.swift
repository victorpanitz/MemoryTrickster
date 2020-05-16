import Foundation

public protocol MemoryOrchestratable {
    func run()
    func stop()
}

protocol MemoryOrchestratableInput {
    func handleMemoryModification(with modifier: MemoryModifier)
    func clearMemory()
    func unplugTimer()
}

public final class MemoryOrchestrator {
    weak var presenter: MemoryPresetationLogic?
    private let memoryBridge: MemoryBridgeInterface
    private let repeats: Bool
    private let timeInterval: TimeInterval
    private var timer: Timer?

    public static var shared: MemoryOrchestratable = MemoryTricksterFactory.makeOrchestrator()
    
    init(
        memoryBridge: MemoryBridgeInterface = MemoryBridge(),
        repeats: Bool = true,
        timeInterval: TimeInterval = 1.0,
        timer: Timer = Timer()
    ) {
        self.memoryBridge = memoryBridge
        self.repeats = repeats
        self.timeInterval = timeInterval
        self.timer = timer
    }

    private func handleMemoryResult(with memoryResult: MemoryResult) {
        switch memoryResult {
        case .success(let memory):
            presenter?.didGetMemoryReportWithSuccess(with: memory)
        case .failure(let error):
            presenter?.didGetMemoryReportWithError(error)
        }
    }
}

extension MemoryOrchestrator: MemoryOrchestratable {
    public func run() {
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: repeats) { [memoryBridge] _ in
            memoryBridge.getMemoryDetails(completion: self.handleMemoryResult(with:))
        }
    }

    public func stop() {
        timer?.invalidate()
        timer = nil
    }
}

extension MemoryOrchestrator: MemoryOrchestratableInput {
    func handleMemoryModification(with modifier: MemoryModifier) {
        let bytes = modifier.magnitude.scale * modifier.multiplier.value
        switch modifier.action {
        case .alloc:
            memoryBridge.injectBytes(bytes)
        case .dealloc:
            memoryBridge.removeBytes(bytes)
        }
    }
    
    func clearMemory() {
        memoryBridge.clearMemory()
    }
    
    func unplugTimer() {
        stop()
    }
}
