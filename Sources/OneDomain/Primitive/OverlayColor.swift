import Foundation

/// Overlay color (primitive.Color).
public struct OverlayColor: Decodable, Equatable, Sendable {
    public let red: Int?
    public let green: Int?
    public let blue: Int?
    public let alpha: Int?

    private enum CodingKeys: String, CodingKey {
        case red
        case green
        case blue
        case alpha
    }
}
