import EncodeDecode
import Foundation
import Testing
@testable import OneDomain

@Suite("ArchiveListPage decoding")
struct ArchiveListPageDecodingTests {
    private let decoder = JSONDecoder()

    @Test("decode raw v1_domain_archives_2_10_0_full.sse")
    func decode_sse_full() throws {
        let raw = try FixtureLoader.loadData(resource: "v1_domain_archives_2_10_0_full", ext: "sse")
        let pages = try decodeSse(ArchiveListPage.self, from: raw, using: decoder)
        let withItems = try #require(pages.first { !$0.items.isEmpty })
        #expect(withItems.items.count == 2)
        #expect(withItems.nextPageToken == "")
    }
}
