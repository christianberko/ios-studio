/// Shared foundation for apps in the ios-studio monorepo.
public enum OverloadKit {
    /// Semantic version of the shared kit. Bump when you publish breaking API changes.
    public static let version = "0.1.0"
}

/// Mass value used across workout-style apps. Stored in kilograms; pounds are derived.
public struct Mass: Equatable, Sendable {
    public let kilograms: Double

    public init(kilograms: Double) {
        self.kilograms = kilograms
    }

    public var pounds: Double {
        kilograms * 2.204_622_621_8
    }
}
