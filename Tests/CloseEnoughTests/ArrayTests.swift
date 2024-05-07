import XCTest
import CloseEnough

final class ArrayTests: XCTestCase {

    func testArray() {
        struct MyThing: Equatable {
            @CloseEnough var values: [Double]
        }
        let a = MyThing(values: [1234, 999])
        let b = MyThing(values: [1234.0002, 999.0002])
        let c = MyThing(values: [1234.0002, 999.1])

        withPrecisions([
            [Double].self: 0.001,
        ]) {
            XCTAssertEqual(a, b)
            XCTExpectFailure {
                XCTAssertEqual(a, c)
            }
        }

        withPrecisions([
            [Double].self: 0.0001,
        ]) {
            XCTExpectFailure {
                XCTAssertEqual(a, b)
            }
            XCTExpectFailure {
                XCTAssertEqual(a, c)
            }
        }
    }

    func testArrayDifferentCount() {
        struct MyThing: Equatable {
            @CloseEnough var values: [Double]
        }
        let a = MyThing(values: [1234, 999])
        let b = MyThing(values: [1234])

        withPrecisions([
            [Double].self: 0.1,
        ]) {
            XCTExpectFailure {
                XCTAssertEqual(a, b)
            }
        }
    }
}
