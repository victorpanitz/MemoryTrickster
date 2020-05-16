import XCTest

@testable import MemoryTrickster

class Int64ExtensionsTests: XCTestCase {
    func test_toMemoryUnity_case_bytes() {
        given("value is in range of 0..<1_024") {
            let testCaseA: Int64 = 0
            let testCaseB: Int64 = 500
            let testCaseC: Int64 = 1023
            
            when("the Int64 extension toMemoryUnity is called over the respective value") {
                let resultA = testCaseA.toMemoryUnity()
                let resultB = testCaseB.toMemoryUnity()
                let resultC = testCaseC.toMemoryUnity()
                
                then("the result value should keep the magnitude and contain the suffix 'B'") {
                    XCTAssertEqual(resultA, "0 B")
                    XCTAssertEqual(resultB, "500 B")
                    XCTAssertEqual(resultC, "1023 B")
                }
            }
        }
    }
    
    func test_toMemoryUnity_case_kiloBytes() {
        given("value is in range of 1_024..<(1_024 * 1_024)") {
            let testCaseA: Int64 = 1024
            let testCaseB: Int64 = 500000
            let testCaseC: Int64 = 1048575
            
            when("the Int64 extension toMemoryUnity is called over the respective value") {
                let resultA = testCaseA.toMemoryUnity()
                let resultB = testCaseB.toMemoryUnity()
                let resultC = testCaseC.toMemoryUnity()
                
                then("the result value should transform the magnitude and contain the suffix 'KB'") {
                    XCTAssertEqual(resultA, "1.00 KB")
                    XCTAssertEqual(resultB, "488.28 KB")
                    XCTAssertEqual(resultC, "1024.00 KB")
                }
            }
        }
    }
    
    func test_toMemoryUnity_case_megaBytes() {
        given("value is in range of (1_024 * 1_024)..<(1_024 * 1_024 * 1_024)") {
            let testCaseA: Int64 = 1048576
            let testCaseB: Int64 = 500000000
            let testCaseC: Int64 = 1073741823
            
            when("the Int64 extension toMemoryUnity is called over the respective value") {
                let resultA = testCaseA.toMemoryUnity()
                let resultB = testCaseB.toMemoryUnity()
                let resultC = testCaseC.toMemoryUnity()
                
                then("the result value should transform the magnitude and contain the suffix 'MB'") {
                    XCTAssertEqual(resultA, "1.00 MB")
                    XCTAssertEqual(resultB, "476.84 MB")
                    XCTAssertEqual(resultC, "1024.00 MB")
                }
            }
        }
    }
    
    func test_toMemoryUnity_case_gigaBytes() {
        given("value is in range of (1_024 * 1_024 * 1024)...Int64.max") {
            let testCaseA: Int64 = 1073741824
            let testCaseB: Int64 = 2147483648
            let testCaseC: Int64 = 5368709120
            
            when("the Int64 extension toMemoryUnity is called over the respective value") {
                let resultA = testCaseA.toMemoryUnity()
                let resultB = testCaseB.toMemoryUnity()
                let resultC = testCaseC.toMemoryUnity()
                
                then("the result value should transform the magnitude and contain the suffix 'GB'") {
                    XCTAssertEqual(resultA, "1.000 GB")
                    XCTAssertEqual(resultB, "2.000 GB")
                    XCTAssertEqual(resultC, "5.000 GB")
                }
            }
        }
    }
}
