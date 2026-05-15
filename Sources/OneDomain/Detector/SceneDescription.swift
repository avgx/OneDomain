import Foundation

/// Scene description for detector.
public struct SceneDescription: Decodable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let mimetype: String

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case mimetype
    }
}
