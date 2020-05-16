struct MemoryModifier: Equatable {
    let action: MemoryAction
    let magnitude: MemoryMagnitude
    let multiplier: MemoryMultiplier
}

enum MemoryMagnitude: CaseIterable, Equatable {
    case bytes
    case kiloBytes
    case megaBytes
    case gigaBytes
    
    var shortName: String {
        switch self {
        case .bytes:
            return "B"
        case .kiloBytes:
            return "KB"
        case .megaBytes:
            return "MB"
        case .gigaBytes:
            return "GB"
        }
    }
    
    var scale: Int {
        switch self {
        case .bytes:
            return 1
        case .kiloBytes:
            return 1_024
        case .megaBytes:
            return 1_024 * 1_024
        case .gigaBytes:
            return 1_024 * 1_024 * 1_024
        }
    }   
}

enum MemoryAction: Equatable {
    case alloc
    case dealloc
}

enum MemoryMultiplier: CaseIterable, Equatable {
    case one
    case ten
    case hundred
    
    var shortName: String {
        switch self {
        case .one:
            return "x1"
        case .ten:
            return "x10"
        case .hundred:
            return "x100"
        }
    }
    
    var value: Int {
        switch self {
        case .one:
            return 1
        case .ten:
            return 10
        case .hundred:
            return 100
        }
    }
}
