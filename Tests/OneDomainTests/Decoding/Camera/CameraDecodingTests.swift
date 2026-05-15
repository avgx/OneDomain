import EncodeDecode
import Foundation
import Testing
@testable import OneDomain

@Suite("Camera decoding")
struct CameraDecodingTests {
    private let decoder = JSONDecoder()

    @Test("decode camera from v1_domain_cameras_1_0_4.json")
    func decode_1_0_4() throws {
        let camera = try FixtureLoader.firstCamera(resource: "v1_domain_cameras_1_0_4", ext: "json", decoder: decoder)
        #expect(camera.accessPoint.isEmpty == false)
        #expect(camera.videoStreams == nil)
        #expect(camera.panomorph == nil)
        #expect(camera.alternativeView == nil)
    }

    @Test("decode camera from v1_domain_cameras_2_0_0.json")
    func decode_2_0_0() throws {
        let camera = try FixtureLoader.firstCamera(resource: "v1_domain_cameras_2_0_0", ext: "json", decoder: decoder)
        #expect(camera.videoStreams != nil)
        #expect(camera.panomorph != nil)
        #expect(camera.alternativeView != nil)
        #expect(camera.groupIds?.isEmpty == false)
    }

    @Test("decode camera from v1_domain_cameras_3_0_0.json")
    func decode_3_0_0() throws {
        let camera = try FixtureLoader.firstCamera(resource: "v1_domain_cameras_3_0_0", ext: "json", decoder: decoder)
        #expect(camera.enabled == true)
        #expect(camera.comment != nil)
    }

    @Test("decode cameras from raw multipart v1_domain_cameras_1_0_4.multipart")
    func decode_multipart() throws {
        let raw = try FixtureLoader.loadData(resource: "v1_domain_cameras_1_0_4", ext: "multipart")
        let pages = try decodeMultipartRelated(
            CameraListPage.self,
            contentType: "multipart/related; boundary=ngpboundary",
            from: raw,
            using: decoder
        )
        let withItems = try #require(pages.first { !$0.items.isEmpty })
        #expect(withItems.items.first?.accessPoint.isEmpty == false)
    }

    @Test("decode cameras from raw SSE v1_domain_cameras_2_0_0.sse")
    func decode_sse_2_0_0() throws {
        let raw = try FixtureLoader.loadData(resource: "v1_domain_cameras_2_0_0", ext: "sse")
        let pages = try decodeSse(CameraListPage.self, from: raw, using: decoder)
        let withItems = try #require(pages.first { !$0.items.isEmpty })
        #expect(withItems.items.first?.displayName.isEmpty == false)
    }

    @Test("decode cameras from raw SSE v1_domain_cameras_3_0_0.sse")
    func decode_sse_3_0_0() throws {
        let raw = try FixtureLoader.loadData(resource: "v1_domain_cameras_3_0_0", ext: "sse")
        let pages = try decodeSse(CameraListPage.self, from: raw, using: decoder)
        #expect(pages.contains { !$0.items.isEmpty })
    }

    @Test("decode camera JSON string from v1_domain_cameras_2_0_0.json items[0]")
    func decode_camera_json_string() throws {
        let json = try FixtureLoader.firstCameraJSON(resource: "v1_domain_cameras_2_0_0", ext: "json")
        let camera = try decoder.decode(Camera.self, from: json)
        #expect(camera.cameraAccess.rawValue == "CAMERA_ACCESS_FULL")
    }
}
