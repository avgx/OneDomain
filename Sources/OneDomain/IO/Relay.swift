import Foundation

/// Relay control.
public struct Relay: Codable, Equatable, Sendable, Identifiable {
    public var id: String { accessPoint }

    public let accessPoint: AccessPoint
    public let displayName: String
    public let displayId: String
    public let isActivated: Bool
    public let enabled: Bool

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case displayName = "display_name"
        case displayId = "display_id"
        case isActivated = "is_activated"
        case enabled
    }
}
