import Foundation
import Testing
@testable import OneDomain

@Suite("AccessPoint decoding")
struct AccessPointDecodingTests {
    @Test("decode from camera access_point")
    func decode_from_fixture() throws {
        let camera = try FixtureLoader.firstCamera(resource: "v1_domain_cameras_1_0_4", ext: "json")
        let json = "\"\(camera.accessPoint)\""
        let value = try JSONDecoder().decode(AccessPoint.self, from: Data(json.utf8))
        #expect(value == camera.accessPoint)
    }
}
