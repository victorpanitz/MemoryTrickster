@testable import MemoryTrickster

final class TimerSpy: Timer {
    private(set) var invalidateCalled: Bool = false
    override func invalidate() {
        invalidateCalled = true
    }
}
