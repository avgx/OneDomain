import Foundation
import Testing
@testable import OneDomain

@Suite("Circles decoding")
struct CirclesDecodingTests {
    @Test("decode from v1_domain_cameras_2_0_0.json panomorph.fisheye_circles")
    func decode_from_fixture() throws {
        let data = try FixtureLoader.nestedJSON(
            key: "fisheye_circles",
            resource: "v1_domain_cameras_2_0_0",
            ext: "json",
            parentKey: "panomorph"
        )
        let value = try JSONDecoder().decode(Circles.self, from: data)
        #expect(value.circle.isEmpty == false)
    }
}
