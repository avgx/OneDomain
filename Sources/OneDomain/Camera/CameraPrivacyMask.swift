import Foundation

/// Camera privacy mask.
public struct CameraPrivacyMask: Codable, Equatable, Sendable {
    public let id: String
    public let value: PrivacyMask?

    /// Privacy mask data.
    public struct PrivacyMask: Codable, Equatable, Sendable {}  //TODO: fix it

    private enum CodingKeys: String, CodingKey {
        case id
        case value
    }
}
