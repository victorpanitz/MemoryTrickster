import XCTest

@testable import MemoryTrickster

final class MemoryBridgeTests: XCTestCase {

    private let memoryBuffer = MemoryBufferInterfaceSpy()
    private lazy var sut = MemoryBridge(memoryBuffer: memoryBuffer)
    
    func test_injectBytes_case_generic() {
        given("inject bytes triggered") {
            sut.injectBytes(10)
            
            then("should delegate respective received bytes to injection method on memory buffer") {
                XCTAssertTrue(memoryBuffer.addCalled)
                XCTAssertEqual(memoryBuffer.addBytesPassed, 10)
            }
        }
    }
    
    func test_removeBytes_case_generic() {
        given("remove bytes triggered") {
            sut.removeBytes(10)
            
            then("should delegate respective received bytes to removal method on memory buffer") {
                XCTAssertTrue(memoryBuffer.removeCalled)
                XCTAssertEqual(memoryBuffer.removeBytesPassed, 10)
            }
        }
    }
    
    func test_clearMemory_case_generic() {
        given("clear memory triggered") {
            sut.clearMemory()
            
            then("should delegate clear memory method on memory buffer") {
                XCTAssertTrue(memoryBuffer.clearCalled)
            }
        }
    }
    
}
