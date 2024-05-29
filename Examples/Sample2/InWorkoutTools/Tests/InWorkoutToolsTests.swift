//  Copyright © 2024, Inova IT – All Rights Reserved.
//
//  All information contained here is in property of Inova IT, but
//  not limited to, technical and intellectual concepts which may be embodied within.
//
//  Dissemination or reproduction of this material is strictly forbidden unless prior written
//  permission, via license, is obtained from Inova IT. If permission is obtained,
//  this notice, and any other such legal notices, must remain unaltered.

import Foundation
import XCTest
import InWorkoutTools

final class InWorkoutToolsTests: XCTestCase {
    func test_duration_test() {
        XCTAssertEqual("1m", toDurationLongString(duration: 60_000)) 
        XCTAssertEqual("1m 1s", toDurationLongString(duration: 61_000))
        XCTAssertEqual("1h", toDurationLongString(duration: 3600_000))
        XCTAssertEqual("1h 1m 1s", toDurationLongString(duration: 3661_000))
        XCTAssertEqual("1h 1s", toDurationLongString(duration: 3601_000))
        XCTAssertEqual("1h 1m", toDurationLongString(duration: 3660_000))
        XCTAssertEqual("59m 50s", toDurationLongString(duration: 3590_000))
    }
}
