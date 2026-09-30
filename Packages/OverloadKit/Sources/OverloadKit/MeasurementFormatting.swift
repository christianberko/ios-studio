import Foundation

/// Small formatting helpers shared by unit types in the kit.
public enum MeasurementFormatting {
    /// Locale-stable fixed-point formatting for values that must match in tests.
    public static func fixed(_ value: Double, fractionDigits: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.string(from: NSNumber(value: value)) ?? String(value)
    }
}
