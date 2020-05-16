public final class MemoryTricksterFactory {
    public static func makeOrchestrator(with timeInterval: TimeInterval = 1.0) -> MemoryOrchestratable {
        let orchestrator = MemoryOrchestrator(timeInterval: timeInterval)
        let presenter = MemoryPresenter(orchestrator: orchestrator)
        let displayer = MemoryDisplayer(presenter: presenter)
        
        orchestrator.presenter = presenter
        presenter.view = displayer
        
        return orchestrator
    }
    
    public static func makeMemoryBridge() -> MemoryBridgeInterface {
        return MemoryBridge()
    }
}
