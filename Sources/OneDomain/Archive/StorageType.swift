import Foundation

/// Storage type.
public enum StorageType: String, Codable, Hashable, Sendable {
    case block = "ST_BLOCK"
    case object = "ST_OBJECT"
    case embedded = "ST_EMBEDDED"
}
