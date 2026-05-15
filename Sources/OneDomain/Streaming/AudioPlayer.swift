import Foundation

/// Represents an audio player for a speaker.
public struct AudioPlayer: Decodable, Equatable, Sendable {
    public let stateControlAp: AccessPoint?
    public let audioSourceAp: AccessPoint?
    public let filePath: String?

    private enum CodingKeys: String, CodingKey {
        case stateControlAp = "state_control_ap"
        case audioSourceAp = "audio_source_ap"
        case filePath = "file_path"
    }
}
