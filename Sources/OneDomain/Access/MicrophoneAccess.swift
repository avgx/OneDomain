import Foundation

public enum MicrophoneAccess: String, Codable, Hashable, Sendable {
    case unspecified = "MICROPHONE_ACCESS_UNSPECIFIED"
    case forbid = "MICROPHONE_ACCESS_FORBID"
}
