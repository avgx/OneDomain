import Foundation
import Testing
@testable import OneDomain

@Suite("Circle decoding")
struct CircleDecodingTests {
    @Test("decode from v1_domain_cameras_2_0_0.json panomorph.fisheye_circles")
    func decode_from_fixture() throws {
        let circlesData = try FixtureLoader.nestedJSON(
            key: "fisheye_circles",
            resource: "v1_domain_cameras_2_0_0",
            ext: "json",
            parentKey: "panomorph"
        )
        let circles = try JSONDecoder().decode(Circles.self, from: circlesData)
        let circle = try #require(circles.circle.first)
        #expect(circle.radius == 0)
    }
}
