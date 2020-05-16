import XCTest

@testable import MemoryTrickster

final class MemoryBufferTests: XCTestCase {

    private let sut = MemoryBuffer()
    
    func test_add_case_generic() {
        given("add bytes triggered") {
            
            then("should update size and buffer properly") {
                sut.add(bytes: 10)
                
                XCTAssertEqual(sut.size, 10)
                XCTAssertEqual(sut.buffer.count, 1)
                
                sut.add(bytes: 16)
                
                XCTAssertEqual(sut.size, 26)
                XCTAssertEqual(sut.buffer.count, 2)
            }
        }
    }

}
    