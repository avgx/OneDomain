import EncodeDecode
import Foundation
import Testing
@testable import OneDomain

@Suite("AccessPoint decoding")
struct AccessPointDecodingTests {
    private let decoder = JSONDecoder()

    @Test("decode from camera access_point")
    func decode_from_fixture() throws {
        let camera = try FixtureLoader.firstCamera(resource: "v1_domain_cameras_1_0_4", ext: "json")
        let json = "\"\(camera.accessPoint)\""
        let value = try decoder.decode(AccessPoint.self, from: Data(json.utf8))
        #expect(value == camera.accessPoint)
    }

    @Test("decode access point shapes from VIEW_MODE_FULL cameras SSE")
    func decode_shapes_from_cameras_full_sse() throws {
        let raw = try FixtureLoader.loadData(resource: "v1_domain_cameras_2_10_0_full", ext: "sse")
        let pages = try decodeSse(CameraListPage.self, from: raw, using: decoder)
        let cameras = pages.flatMap(\.items)
        #expect(cameras.count == 2)

        let endpoint = try #require(cameras.first?.accessPoint)
        #expect(endpoint.components(separatedBy: "/").count == 4)
        #expect(endpoint.nohosts == "DemoServer/DeviceIpint.1/SourceEndpoint.video:0:0")

        let source = try #require(cameras.first?.archiveBindings?.first?.sources.first?.accessPoint)
        #expect(source.components(separatedBy: "/").count == 5)

        let detector = try #require(cameras.last?.detectors?.last)
        #expect(detector.parentDetector?.isEmpty == false)
    }

    @Test("decode access point shapes from VIEW_MODE_FULL archives SSE")
    func decode_shapes_from_archives_full_sse() throws {
        let raw = try FixtureLoader.loadData(resource: "v1_domain_archives_2_10_0_full", ext: "sse")
        let pages = try decodeSse(ArchiveListPage.self, from: raw, using: decoder)
        let archives = pages.flatMap(\.items)
        #expect(archives.count == 2)

        let embedded = try #require(archives.first)
        #expect(embedded.accessPoint.contains("/MultimediaStorage.0"))
        #expect(embedded.accessPoint.components(separatedBy: "/").count == 4)

        let central = try #require(archives.last)
        let uuidSource = central.bindings.flatMap(\.sources).first {
            $0.accessPoint.contains("/Sources/src.") && $0.accessPoint.contains("-")
        }
        #expect(uuidSource != nil)
        #expect(uuidSource?.originStorage?.isEmpty == true)
    }
}
