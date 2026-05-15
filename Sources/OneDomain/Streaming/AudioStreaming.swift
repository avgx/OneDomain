import Foundation
import SafeEnum

/// Audio streaming configuration.
public struct AudioStreaming: Codable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let displayName: String
    public let displayId: String
    public let microphoneAccess: SafeEnum<MicrophoneAccess>?
    public let isActivated: Bool
    public let enabled: Bool

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case displayName = "display_name"
        case displayId = "display_id"
        case microphoneAccess = "microphone_access"
        case isActivated = "is_activated"
        case enabled
    }
}


