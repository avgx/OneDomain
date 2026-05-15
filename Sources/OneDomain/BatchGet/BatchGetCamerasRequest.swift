import Foundation

public struct BatchGetCamerasRequest: Codable, Equatable, Sendable {
    /// NOTE: Default view is FULL.
    public let items: [ResourceLocator]

    private enum CodingKeys: String, CodingKey {
        case items
    }
}
