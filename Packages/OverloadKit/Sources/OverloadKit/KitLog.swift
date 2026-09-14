import Foundation
import os

/// Thin logging facade so apps share a consistent subsystem without picking a logger per project.
public enum KitLog {
    private static let logger = Logger(subsystem: "com.christianberko.overloadkit", category: "app")

    public static func debug(_ message: String) {
        logger.debug("\(message, privacy: .public)")
    }

    public static func info(_ message: String) {
        logger.info("\(message, privacy: .public)")
    }

    public static func error(_ message: String) {
        logger.error("\(message, privacy: .public)")
    }
}
