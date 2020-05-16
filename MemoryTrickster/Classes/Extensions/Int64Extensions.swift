extension Int64 {
    func toMemoryUnity() -> String {
        let kilobytes = Double(self) / 1_024
        let megabytes = kilobytes / 1_024
        let gigabytes = megabytes / 1_024
        
        switch self {
        case 0..<1_024:
            return "\(self) B"
        case 1_024..<(1_024 * 1_024):
            return "\(String(format: "%.2f", kilobytes)) KB"
        case 1_024..<(1_024 * 1_024 * 1_024):
            return "\(String(format: "%.2f", megabytes)) MB"
        case (1_024 * 1_024 * 1_024)...Int64.max:
            return "\(String(format: "%.3f", gigabytes)) GB"
        default:
            return "\(self) B"
        }
    }
}
