import Foundation

public enum MemoryError: Error {
    case memoryOffset
    case kernResult

    public var message: String {
        switch self {
        case .memoryOffset: return "Error regarding memory offset"
        case .kernResult: return "Error regarding kern result"
        }
    }
}
