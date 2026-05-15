import Foundation

/// Storage source for archiving.
public struct StorageSource: Decodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let storage: String
    public let binding: String
    public let mediaSource: String
    public let origin: String
    public let mimetype: String
    public let originStorage: String
    public let originStorageSource: String
    public let prerecording: Int

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case storage
        case binding
        case mediaSource = "media_source"
        case origin
        case mimetype
        case originStorage = "origin_storage"
        case originStorageSource = "origin_storage_source"
        case prerecording
    }
}

