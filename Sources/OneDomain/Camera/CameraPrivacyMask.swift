import Foundation

/// Camera privacy mask.
public struct CameraPrivacyMask: Decodable, Equatable, Sendable {
    public let id: String
    public let value: PrivacyMask?

    /// Privacy mask data.
    public struct PrivacyMask: Decodable, Equatable, Sendable {}

    private enum CodingKeys: String, CodingKey {
        case id
        case value
    }
}
