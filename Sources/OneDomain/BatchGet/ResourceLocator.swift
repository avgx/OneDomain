import Foundation

/// Resource locator for batch operations.
public struct ResourceLocator: Codable, Equatable, Sendable {
    public enum View: String, Codable, Equatable, Sendable {
        case unspecified = "VIEW_UNSPECIFIED"
        case basic = "BASIC"
        case full = "FULL"
    }

    public let accessPoint: AccessPoint
    public let view: View?

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case view
    }
}
