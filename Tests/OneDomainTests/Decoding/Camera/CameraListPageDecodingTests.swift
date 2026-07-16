import EncodeDecode
import Foundation
import Testing
@testable import OneDomain

@Suite("CameraListPage decoding")
struct CameraListPageDecodingTests {
    private let decoder = JSONDecoder()

    @Test("decode v1_domain_cameras_1_0_4.json")
    func decode_json_1_0_4() throws {
        let page = try FixtureLoader.loadListPage(resource: "v1_domain_cameras_1_0_4", ext: "json", decoder: decoder)
        #expect(page.items.isEmpty == false)
        #expect(page.nextPageToken == "")
    }

    @Test("decode v1_domain_cameras_2_0_0.json")
    func decode_json_2_0_0() throws {
        let page = try FixtureLoader.loadListPage(resource: "v1_domain_cameras_2_0_0", ext: "json", decoder: decoder)
        #expect(page.items.count > 1)
    }

    @Test("decode v1_domain_cameras_3_0_0.json")
    func decode_json_3_0_0() throws {
        let page = try FixtureLoader.loadListPage(resource: "v1_domain_cameras_3_0_0", ext: "json", decoder: decoder)
        #expect(page.items.isEmpty == false)
    }

    @Test("decode raw v1_domain_cameras_1_0_4.multipart")
    func decode_multipart() throws {
        let raw = try FixtureLoader.loadData(resource: "v1_domain_cameras_1_0_4", ext: "multipart")
        let pages = try decodeMultipartRelated(
            CameraListPage.self,
            contentType: "multipart/related; boundary=ngpboundary",
            from: raw,
            using: decoder
        )
        #expect(pages.count >= 2)
    }

    @Test("decode raw v1_domain_cameras_2_0_0.sse")
    func decode_sse_2_0_0() throws {
        let raw = try FixtureLoader.loadData(resource: "v1_domain_cameras_2_0_0", ext: "sse")
        let pages = try decodeSse(CameraListPage.self, from: raw, using: decoder)
        #expect(pages.isEmpty == false)
    }

    @Test("decode raw v1_domain_cameras_3_0_0.sse")
    func decode_sse_3_0_0() throws {
        let raw = try FixtureLoader.loadData(resource: "v1_domain_cameras_3_0_0", ext: "sse")
        let pages = try decodeSse(CameraListPage.self, from: raw, using: decoder)
        #expect(pages.isEmpty == false)
    }

    @Test("decode raw v1_domain_cameras_2_10_0_full.sse")
    func decode_sse_full() throws {
        let raw = try FixtureLoader.loadData(resource: "v1_domain_cameras_2_10_0_full", ext: "sse")
        let pages = try decodeSse(CameraListPage.self, from: raw, using: decoder)
        let withItems = try #require(pages.first { !$0.items.isEmpty })
        #expect(withItems.items.count == 2)
    }

    @Test("decode paginated multipart with next_page_token")
    func decode_page_token_multipart() throws {
        let raw = try FixtureLoader.loadData(resource: "v1_domain_cameras_page_token", ext: "multipart")
        let pages = try decodeMultipartRelated(
            CameraListPage.self,
            contentType: "multipart/related; boundary=ngpboundary",
            from: raw,
            using: decoder
        )
        #expect(pages.count == 3)
        #expect(pages[0].items.count == 2)
        #expect(pages[0].nextPageToken == "")
        #expect(pages[1].items.isEmpty)
        #expect(pages[1].nextPageToken == "NodeA|hosts/NodeA/DeviceIpint.2/SourceEndpoint.video:0:0")
        #expect(pages[2].items.isEmpty)
        #expect(pages[2].nextPageToken == "")
    }

    @Test("decode paginated SSE with next_page_token")
    func decode_page_token_sse() throws {
        let raw = try FixtureLoader.loadData(resource: "v1_domain_cameras_page_token", ext: "sse")
        let pages = try decodeSse(CameraListPage.self, from: raw, using: decoder)
        let withItems = try #require(pages.first { !$0.items.isEmpty })
        #expect(withItems.items.count == 2)
        let withToken = try #require(pages.first { !$0.nextPageToken.isEmpty })
        #expect(withToken.nextPageToken == "CkJEZW1vc2VydmVyfGhvc3RzL0RlbW9zZXJ2ZXIvRGV2aWNlSXBpbnQuMi9Tb3VyY2VFbmRwb2ludC52aWRlbzowOjA")
        #expect(pages.last?.nextPageToken == "")
    }

    @Test("reject malformed race-corrupted multipart")
    func decode_malformed_race_multipart() throws {
        let raw = try FixtureLoader.loadData(resource: "v1_domain_cameras_malformed_race", ext: "multipart")
        #expect(throws: MultipartError.boundaryBeforeContentLengthEnd(contentLength: 300, boundaryOffset: 175)) {
            try decodeMultipartRelated(
                CameraListPage.self,
                contentType: "multipart/related; boundary=ngpboundary",
                from: raw,
                using: decoder
            )
        }
    }
}
