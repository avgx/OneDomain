import Foundation

/// Chunk of archive list stream (ListArchivesResponse).
public struct ArchiveListPage: Decodable, Equatable, Sendable {
    public let items: [Archive]
    public let nextPageToken: String

    private enum CodingKeys: String, CodingKey {
        case items
        case nextPageToken = "next_page_token"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([Archive].self, forKey: .items)
        nextPageToken = try container.decodeIfPresent(String.self, forKey: .nextPageToken) ?? ""
    }
}
