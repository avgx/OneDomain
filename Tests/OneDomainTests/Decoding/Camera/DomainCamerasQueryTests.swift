import EncodeDecode
import Foundation
import Testing
@testable import OneDomain

@Suite("Domain cameras query")
struct DomainCamerasQueryTests {
    private let accessPoint = "hosts/Demoserver/DeviceIpint.1/SourceEndpoint.video:0:0"

    @Test("cameras request sends SearchQuery for one access point")
    func requestQueryItems() {
        let request = DomainApi.cameras(
            view: .VIEW_MODE_FULL,
            query: .accessPoint(accessPoint)
        )
        let query = request.query ?? []
        #expect(query.contains { $0.0 == "view" && $0.1 == "VIEW_MODE_FULL" })
        #expect(query.contains { $0.0 == "query.query" && $0.1 == accessPoint })
        #expect(query.contains { $0.0 == "query.search_fields" && $0.1 == "ACCESS_POINT" })
        #expect(query.contains { $0.0 == "query.search_type" && $0.1 == "SUBSTRING" })
    }

    @Test("decode try.axxonsoft.com response for one camera")
    func decodeDemoAccessPointResponse() throws {
        let raw = try FixtureLoader.loadData(resource: "v1_domain_cameras_try_access_point", ext: "sse")
        let pages = try decodeSse(CameraListPage.self, from: raw, using: JSONDecoder())
        let cameras = pages.flatMap(\.items)
        #expect(cameras.count == 1)
        let camera = try #require(cameras.first)
        #expect(camera.accessPoint == accessPoint)
        #expect(camera.displayName == "Stairs")
        #expect(camera.armed == false)
    }
}
