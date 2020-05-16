// Are you interested on the current description approach?
// check it here:
// https://medium.com/flawless-app-stories/ios-achieving-maximum-test-readability-at-no-cost-906af0dbaa98#503f-54b93f250bfb

import os.log
import XCTest

func given<A>(_ description: String, block: () throws -> A) rethrows -> A {
    os_log("1º Given %{public}@", description)
    return try XCTContext.runActivity(named: "Given " + description, block: { _ in try block() })
}

func when<A>(_ description: String, block: () throws -> A) rethrows -> A {
    os_log("2º When %{public}@", description)
    return try XCTContext.runActivity(named: "When " + description, block: { _ in try block() })
}

func then<A>(_ description: String, block: () throws -> A) rethrows -> A {
    os_log("3º Then %{public}@", description)
    return try XCTContext.runActivity(named: "Then " + description, block: { _ in try block() })
}
