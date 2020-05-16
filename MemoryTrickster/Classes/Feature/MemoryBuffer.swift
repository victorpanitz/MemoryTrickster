import Foundation

protocol MemoryBufferInterface: AnyObject {
    var buffer: [[Int8]] { get }
    var size: Int { get }
    
    func add(bytes: Int)
    func remove(bytes: Int)
    func clear()
}

class MemoryBuffer: MemoryBufferInterface {
    var buffer: [[Int8]] = []
    var size: Int = 0
    
    init(){}
    
    func add(bytes: Int) {
        let count = bytes
        size += bytes
        buffer.append(Array(repeating: Int8(), count: count))
    }
    
    func remove(bytes: Int) {
        let newSize = (size - bytes)
        let count = max(0, newSize)
       
        size = count
        buffer = [Array(repeating: Int8(), count: count)]
    }
    
    func clear() {
        size = 0
        buffer.removeAll()
    }
}
