import Foundation
import SafeEnum

/// Telemetry configuration.
public struct Telemetry: Codable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let displayName: String
    public let displayId: String
    public let telemetryPriority: SafeEnum<TelemetryPriority>?
    public let enabled: Bool
    public let capabilities: TelemetryCapabilities?
    public let discreteOverContinuous: Bool
    public let patrolStateControlAccessPoint: AccessPoint
    public let tagAndTrack: TagAndTrack?
    public let isActivated: Bool

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case displayName = "display_name"
        case displayId = "display_id"
        case telemetryPriority = "telemetry_priority"
        case enabled
        case capabilities
        case discreteOverContinuous = "discrete_over_continuous"
        case patrolStateControlAccessPoint = "patrol_state_control_access_point"
        case tagAndTrack = "tag_and_track"
        case isActivated = "is_activated"
    }
}

