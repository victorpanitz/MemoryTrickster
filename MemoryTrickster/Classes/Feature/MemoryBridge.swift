import Foundation

public protocol MemoryBridgeDelegate: AnyObject {
    func didTrackMemory(with result: Result<Bool, Error>)
}

public protocol MemoryBridgeInterface {
    func getMemoryDetails(completion: (MemoryResult) -> ())
    func injectBytes(_ bytes: Int)
    func removeBytes(_ bytes: Int)
    func clearMemory()
}

public typealias MemoryResult = Result<Memory, MemoryError>

final class MemoryBridge {
    private let taskVmInfoCount = mach_msg_type_number_t(MemoryLayout<task_vm_info_data_t>.size / MemoryLayout<integer_t>.size)
    private lazy var info = task_vm_info_data_t()
    private lazy var count = taskVmInfoCount
    private let memoryBuffer: MemoryBufferInterface
    
    init (memoryBuffer: MemoryBufferInterface = MemoryBuffer()) {
        self.memoryBuffer = memoryBuffer
    }
}

extension MemoryBridge: MemoryBridgeInterface {
    public func getMemoryDetails(completion: (MemoryResult) -> ()) {
        guard let memoryOffset = MemoryLayout.offset(of: \task_vm_info_data_t.min_address) else {
            completion(.failure(MemoryError.memoryOffset))
            return
        }

        let taskVmInfoRev1Count = mach_msg_type_number_t(memoryOffset / MemoryLayout<integer_t>.size)
        let kernResult = withUnsafeMutablePointer(to: &info) { infoP in
            infoP.withMemoryRebound(to: integer_t.self, capacity: Int(count)) { intP in
                task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), intP, &count)
            }
        }

        guard
            kernResult == KERN_SUCCESS,
            count >= taskVmInfoRev1Count
        else {
            completion(.failure(MemoryError.kernResult))
            return
        }

        let memory = Memory(
            remaining: Int64(info.limit_bytes_remaining),
            used: Int64(info.phys_footprint),
            injected: Int64(memoryBuffer.size)
        )

        completion(.success(memory))
    }
    
    public func injectBytes(_ bytes: Int) {
        memoryBuffer.add(bytes: bytes)
    }
    
    public func removeBytes(_ bytes: Int) {
        memoryBuffer.remove(bytes: bytes)
    }
    
    public func clearMemory() {
        memoryBuffer.clear()
    }
}
