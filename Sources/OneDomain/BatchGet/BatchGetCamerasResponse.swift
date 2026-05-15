import Foundation

public struct BatchGetCamerasResponse: Decodable, Equatable, Sendable {
    public let items: [Camera]?
    public let notFoundObjects: [String]?
    public let unreachableObjects: [String]?

    private enum CodingKeys: String, CodingKey {
        case items
        case notFoundObjects = "not_found_objects"
        case unreachableObjects = "unreachable_objects"
    }
}
