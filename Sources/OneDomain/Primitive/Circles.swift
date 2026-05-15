import Foundation

/// Circles collection (primitive.Circles).
public struct Circles: Codable, Equatable, Sendable {
    public let circle: [Circle]

    private enum CodingKeys: String, CodingKey {
        case circle
    }
}
