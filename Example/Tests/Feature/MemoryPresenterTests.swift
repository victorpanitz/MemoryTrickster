import XCTest

@testable import MemoryTrickster

final class MemoryPresenterTests: XCTestCase {
    private let view = MemoryDisplayLogicSpy()
    private let orchestrator = MemoryOrchestratableInputSpy()
    private lazy var sut = MemoryPresenter(orchestrator: orchestrator)
    
    func test_memoryModificationTriggered_case_generic() {
        given("a visual memory modifier is configurated"){
            let modifier = MemoryModifier(action: .alloc, magnitude: .kiloBytes, multiplier: .ten)
        
            when("presenter memory modification method get triggered") {
                sut.memoryModificationTriggered(with: modifier)
                
                then("should delegate the modification to the orchestrator") {
                    XCTAssertTrue(orchestrator.handleMemoryModificationCalled)
                    XCTAssertEqual(orchestrator.modifierPassed, modifier)
                }
            }
        }
    }
    
    func test_didGetMemoryReportWithSuccess_case_displayerDelegateIsNil() {
        given("displayer delegate reference is nil") {
            sut.view = nil
            let reportedMemory = Memory(remaining: 10, used: 11, injected: 12)
            
            when("memory report succeeded") {
                sut.didGetMemoryReportWithSuccess(with: reportedMemory)
                
                then("the displayer should not receive anything") {
                    XCTAssertFalse(view.updateInjectedMemoryCalled)
                    XCTAssertNil(view.updateInjectedMemoryPassed)
                    
                    XCTAssertFalse(view.updateUsedMemoryCalled)
                    XCTAssertNil(view.updateUsedMemoryPassed)
                    
                    XCTAssertFalse(view.updateRemainingMemoryCalled)
                    XCTAssertNil(view.updateRemainingMemoryPassed)
                    
                    XCTAssertFalse(view.updateViewVisibilityCalled)
                }
            }
        }
    }
    
    func test_didGetMemoryReportWithSuccess_case_displayerDelegateIsNotNil() {
        given("displayer delegate reference is not nil") {
            sut.view = view
            let reportedMemory = Memory(remaining: 10, used: 11, injected: 12)
            
            when("memory report succeeded") {
                sut.didGetMemoryReportWithSuccess(with: reportedMemory)
                
                then("should call all update methods on through the displayer delegate") {
                    XCTAssertTrue(view.updateInjectedMemoryCalled)
                    XCTAssertEqual(view.updateInjectedMemoryPassed, "12 B")
                    
                    XCTAssertTrue(view.updateUsedMemoryCalled)
                    XCTAssertEqual(view.updateUsedMemoryPassed, "11 B")
                    
                    XCTAssertTrue(view.updateRemainingMemoryCalled)
                    XCTAssertEqual(view.updateRemainingMemoryPassed, "10 B")
                    
                    XCTAssertTrue(view.updateViewVisibilityCalled)
                }
            }
        }
    }
    
    func test_clearMemoryTriggered_case_generic() {
        given("clear memory triggered") {
            sut.clearMemoryTriggered()
            
            then("should delegate clear memory to current orchestrator") {
                XCTAssertTrue(orchestrator.clearMemoryCalled)
            }
        }
    }
    
    func test_stopMemoryTrickster_case_generic() {
        given("stop memory trickster triggered") {
            sut.stopMemoryTrickster()
            
            then("should delegate clear memory to current orchestrator") {
                XCTAssertTrue(orchestrator.clearMemoryCalled)
            }
            
            then("should delegate unplug timer to current orchestrator") {
                XCTAssertTrue(orchestrator.unplugTimerCalled)
            }
        }
    }
    
}
