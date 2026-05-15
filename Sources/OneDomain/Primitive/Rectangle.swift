import Foundation

/// Relative rectangle (primitive.Rectangle).
public struct Rectangle: Decodable, Equatable, Sendable {
    public let x: Double?
    public let y: Double?
    public let w: Double?
    public let h: Double?

    private enum CodingKeys: String, CodingKey {
        case x
        case y
        case w
        case h
    }
}
