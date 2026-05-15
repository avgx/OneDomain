import Foundation

/// Represents a speaker device.
public struct Speaker: Decodable, Equatable, Sendable, Identifiable {
    public var id: String { accessPoint ?? "" }

    public let accessPoint: AccessPoint?
    public let displayName: String?
    public let displayId: String?
    public let stateControlAp: AccessPoint?
    public let audioSourceAp: AccessPoint?
    public let tracks: [AudioPlayer]?
    public let isActivated: Bool?
    public let enabled: Bool?

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case displayName = "display_name"
        case displayId = "display_id"
        case stateControlAp = "state_control_ap"
        case audioSourceAp = "audio_source_ap"
        case tracks
        case isActivated = "is_activated"
        case enabled
    }
}
