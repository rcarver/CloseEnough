import Foundation

extension Comparable where Self: EquatableWithPrecision & SignedNumeric {
    public func isApproximatelyEqual(to other: Self, precision: Self) -> Bool {
        abs(self - other) < precision
    }
}

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *)
extension Float16: EquatableWithPrecision {}

extension Float: EquatableWithPrecision {}
extension Double: EquatableWithPrecision {}

#if canImport(SwiftUI)
import SwiftUI
extension Angle: EquatableWithPrecision {
    public func isApproximatelyEqual(to other: Angle, precision: Angle) -> Bool {
        abs(self.degrees - other.degrees) < precision.degrees
    }
}
#endif

extension Array: EquatableWithPrecision where Element: EquatableWithPrecision, Element.Precision == Element {
    public func isApproximatelyEqual(to other: Self, precision: Element) -> Bool {
        guard self.count == other.count else { return false }
        return zip(self, other).allSatisfy { $0.isApproximatelyEqual(to: $1, precision: precision) }
    }
}

extension Date: EquatableWithPrecision {
    public func isApproximatelyEqual(to other: Date, precision: TimeInterval) -> Bool {
        abs(other.timeIntervalSince(self)) < precision
    }
}
