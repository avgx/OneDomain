import Foundation
import OneWireFormat

/// Scene description for detector.
public struct SceneDescription: Codable, Equatable, Sendable {
    public let accessPoint: AccessPoint
    public let mimetype: String

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case mimetype
    }
}
