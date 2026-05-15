import Foundation

/// Alternative view configuration.
public struct AlternativeView: Codable, Equatable, Sendable {
    public let alternativeCameraName: String
    public let secondAlternativeCameraName: String

    private enum CodingKeys: String, CodingKey {
        case alternativeCameraName = "alternative_camera_name"
        case secondAlternativeCameraName = "second_alternative_camera_name"
    }
}
