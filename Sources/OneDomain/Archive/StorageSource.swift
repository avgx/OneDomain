import Foundation
import OneWireFormat

/// Storage source for archiving.
public struct StorageSource: Codable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let storage: AccessPoint
    public let binding: String  //TODO: check AccessPoint
    public let mediaSource: AccessPoint
    public let origin: AccessPoint
    public let mimetype: String
    /// can be empty string
    public let originStorage: AccessPoint?
    /// can be empty string
    public let originStorageSource: AccessPoint?
    public let prerecording: Int?

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

