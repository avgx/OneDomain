import Foundation

/// Tag and track configuration.
public struct TagAndTrack: Codable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let displayName: String
    public let displayId: String
    public let enabled: Bool

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case displayName = "display_name"
        case displayId = "display_id"
        case enabled
    }
}
