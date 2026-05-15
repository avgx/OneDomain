import Foundation
import SafeEnum

/// Archive configuration.
public struct Archive: Decodable, Equatable, Sendable, Identifiable {
    public var id: String { accessPoint }

    public let accessPoint: AccessPoint
    public let incomplete: Bool
    public let displayName: String
    public let displayId: String
    public let isEmbedded: Bool             // deprecated, use storage_type
    public let archiveAccess: SafeEnum<ArchiveAccess>?
    public let bindings: [ArchiveBinding]
    public let isActivated: Bool
    public let enabled: Bool
    public let storageType: SafeEnum<StorageType>?

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case incomplete
        case displayName = "display_name"
        case displayId = "display_id"
        case isEmbedded = "is_embedded"
        case archiveAccess = "archive_access"
        case bindings
        case isActivated = "is_activated"
        case enabled
        case storageType = "storage_type"
    }
}
