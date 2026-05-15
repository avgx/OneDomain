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
}
