import Foundation
import OneWireFormat

/// Archive binding configuration.
public struct ArchiveBinding: Codable, Equatable, Sendable {
    /// Usually camera or source name.
    public let name: String
    public let storage: AccessPoint
    public let camera: Camera?      //TODO: check it.
    public let archive: Archive?    //TODO: check it.
    public let isDefault: Bool
    public let isReplica: Bool
    public let isPermanent: Bool
    public let hasLiveSources: Bool?
    public let hasReplicaSources: Bool?
    public let originStorage: String?
    public let sources: [StorageSource]

    private enum CodingKeys: String, CodingKey {
        case name
        case storage
        case camera
        case archive
        case isDefault = "is_default"
        case isReplica = "is_replica"
        case isPermanent = "is_permanent"
        case hasLiveSources = "has_live_sources"
        case hasReplicaSources = "has_replica_sources"
        case originStorage = "origin_storage"
        case sources
    }
}
