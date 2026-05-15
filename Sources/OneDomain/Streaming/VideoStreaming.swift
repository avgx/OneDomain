import Foundation

/// Video streaming configuration.
public struct VideoStreaming: Codable, Equatable, Sendable {
    public let streamAcessPoint: AccessPoint
    public let decoderAcessPoint: AccessPoint
    public let enabled: Bool
    public let displayName: String
    public let displayId: String
    /// Framerate (configured).
    public let fps: Int
    public let isActivated: Bool

    private enum CodingKeys: String, CodingKey {
        case streamAcessPoint = "stream_acess_point"
        case decoderAcessPoint = "decoder_acess_point"
        case enabled
        case displayName = "display_name"
        case displayId = "display_id"
        case fps
        case isActivated = "is_activated"
    }
}

