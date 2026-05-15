import Foundation

/// Chunk of camera list stream (ListCamerasResponse).
public struct CameraListPage: Decodable, Equatable, Sendable {
    public let items: [Camera]
    public let nextPageToken: String

    private enum CodingKeys: String, CodingKey {
        case items
        case nextPageToken = "next_page_token"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([Camera].self, forKey: .items)
        nextPageToken = try container.decodeIfPresent(String.self, forKey: .nextPageToken) ?? ""
    }
}
