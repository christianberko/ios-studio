import Foundation

/// Codable key-value persistence used by lightweight app settings and prototypes.
public protocol KeyValueStore: Sendable {
    func value<T: Codable>(forKey key: String, as type: T.Type) throws -> T?
    func set<T: Codable>(_ value: T, forKey key: String) throws
    func removeValue(forKey key: String)
}

/// `UserDefaults`-backed store suitable for small preference blobs.
public final class UserDefaultsStore: KeyValueStore, @unchecked Sendable {
    private let defaults: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(
        defaults: UserDefaults = .standard,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.defaults = defaults
        self.encoder = encoder
        self.decoder = decoder
    }

    public func value<T: Codable>(forKey key: String, as type: T.Type) throws -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        return try decoder.decode(type, from: data)
    }

    public func set<T: Codable>(_ value: T, forKey key: String) throws {
        let data = try encoder.encode(value)
        defaults.set(data, forKey: key)
    }

    public func removeValue(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}

/// In-memory store for tests and previews.
public final class InMemoryKeyValueStore: KeyValueStore, @unchecked Sendable {
    private var storage: [String: Data] = [:]
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private let lock = NSLock()

    public init(
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.encoder = encoder
        self.decoder = decoder
    }

    public func value<T: Codable>(forKey key: String, as type: T.Type) throws -> T? {
        lock.lock()
        defer { lock.unlock() }
        guard let data = storage[key] else { return nil }
        return try decoder.decode(type, from: data)
    }

    public func set<T: Codable>(_ value: T, forKey key: String) throws {
        let data = try encoder.encode(value)
        lock.lock()
        storage[key] = data
        lock.unlock()
    }

    public func removeValue(forKey key: String) {
        lock.lock()
        storage.removeValue(forKey: key)
        lock.unlock()
    }
}
