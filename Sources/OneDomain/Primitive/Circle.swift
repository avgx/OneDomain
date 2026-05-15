import Foundation

/// Circle geometry.
public struct Circle: Codable, Equatable, Sendable {
    public let center: Center?
    public let radius: Double

    /// Circle center point.
    public struct Center: Codable, Equatable, Sendable {
        public let x: Double
        public let y: Double

        private enum CodingKeys: String, CodingKey {
            case x
            case y
        }
    }

    private enum CodingKeys: String, CodingKey {
        case center
        case radius
    }
}
