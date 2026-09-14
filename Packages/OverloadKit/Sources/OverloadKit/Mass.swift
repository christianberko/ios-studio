/// Mass value used across workout-style apps. Canonical storage is kilograms.
public struct Mass: Comparable, Equatable, Hashable, Sendable {
    public let kilograms: Double

    public init(kilograms: Double) {
        self.kilograms = kilograms
    }

    public init(pounds: Double) {
        self.kilograms = pounds / 2.204_622_621_8
    }

    public var pounds: Double {
        kilograms * 2.204_622_621_8
    }

    public static func < (lhs: Mass, rhs: Mass) -> Bool {
        lhs.kilograms < rhs.kilograms
    }

    /// Formats using a fixed fraction digit count (locale-agnostic for tests and logs).
    public func formatted(unit: Unit = .kilograms, fractionDigits: Int = 1) -> String {
        let value = unit == .kilograms ? kilograms : pounds
        let number = MeasurementFormatting.fixed(value, fractionDigits: fractionDigits)
        return "\(number) \(unit.symbol)"
    }
}

extension Mass {
    public enum Unit: String, Sendable {
        case kilograms
        case pounds

        public var symbol: String {
            switch self {
            case .kilograms: "kg"
            case .pounds: "lb"
            }
        }
    }
}
