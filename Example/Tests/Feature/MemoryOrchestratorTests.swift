import XCTest

@testable import MemoryTrickster

final class MemoryOrchestratorTests: XCTestCase {
    private let timerExpectation = XCTestExpectation(description: "timer expectation")
    private let presenter = MemoryPresetationLogicSpy()
    private let timer = TimerSpy()
    private lazy var memoryBridge = MemoryBridgeInterfaceSpy(expectation: timerExpectation)
    private lazy var sut = MemoryOrchestrator(memoryBridge: memoryBridge, repeats: false, timeInterval: 0, timer: timer)
    
    func test_run_case_delegatingSuccess() {
        given("presentation delegate layer is not nil") {
            sut.presenter = presenter
            
            let memory = Memory(remaining: 10, used: 11, injected: 12)
            memoryBridge.memoryResultToBeReturned = .success(memory)
            
            when("get memory details succeeded") {
                sut.run()
                wait(for: [timerExpectation], timeout: 0.2)
                
                then("should delegate the success to the presentation layer") {
                    XCTAssertTrue(presenter.didGetMemoryReportWithSuccessCalled)
                    XCTAssertEqual(presenter.memoryPassed?.remaining, 10)
                    XCTAssertEqual(presenter.memoryPassed?.used, 11)
                    XCTAssertEqual(presenter.memoryPassed?.injected, 12)
                }
            }
        }
    }
    
    func test_run_case_notDelegatingSuccess() {
        given("presentation delegate layer is nil") {
            sut.presenter = nil
            
            let memory = Memory(remaining: 10, used: 11, injected: 12)
            memoryBridge.memoryResultToBeReturned = .success(memory)
            
            when("get memory details succeeded") {
                sut.run()
                wait(for: [timerExpectation], timeout: 0.2)
                
                then("should not delegate the success to the presentation layer") {
                    XCTAssertFalse(presenter.didGetMemoryReportWithSuccessCalled)
                    XCTAssertNil(presenter.memoryPassed?.remaining)
                    XCTAssertNil(presenter.memoryPassed?.used)
                    XCTAssertNil(presenter.memoryPassed?.injected)
                }
            }
        }
    }
    
    func test_run_case_delegatingKernFailure() {
        given("presentation delegate layer is not nil") {
            sut.presenter = presenter
            memoryBridge.memoryResultToBeReturned = .failure(.kernResult)
            
            when("get memory details failed") {
                sut.run()
                wait(for: [timerExpectation], timeout: 0.2)
                
                then("should delegate the failure to the presentation layer") {
                    XCTAssertTrue(presenter.didGetMemoryReportWithErrorCalled)
                    XCTAssertEqual((presenter.errorPassed as? MemoryError)?.message, "Error regarding kern result")
                }
            }
        }
    }
    
    func test_run_case_delegatingMemoryOffsetFailure() {
        given("presentation delegate layer is not nil") {
            sut.presenter = presenter
            memoryBridge.memoryResultToBeReturned = .failure(.memoryOffset)
            
            when("get memory details failed") {
                sut.run()
                wait(for: [timerExpectation], timeout: 0.2)
                
                then("should delegate the failure to the presentation layer") {
                    XCTAssertTrue(presenter.didGetMemoryReportWithErrorCalled)
                    XCTAssertEqual((presenter.errorPassed as? MemoryError)?.message, "Error regarding memory offset")
                }
            }
        }
    }
    
    func test_run_case_notDelegatingFailure() {
        given("presentation delegate layer is nil") {
            sut.presenter = nil
            memoryBridge.memoryResultToBeReturned = .failure(.memoryOffset)
            
            when("get memory details failed") {
                sut.run()
                wait(for: [timerExpectation], timeout: 0.2)
                
                then("should not delegate the failure to the presentation layer") {
                    XCTAssertFalse(presenter.didGetMemoryReportWithErrorCalled)
                    XCTAssertNil(presenter.errorPassed)
                }
            }
        }
    }
    
    func test_stop_case_generic() {
        given("stop called") {
            sut.stop()
            
            then("should invalidate timer") {
                XCTAssertTrue(timer.invalidateCalled)
            }
        }
    }

}
