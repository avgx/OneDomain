import Foundation
import Testing
@testable import OneDomain

@Suite("Panomorph decoding")
struct PanomorphDecodingTests {
    @Test("decode from v1_domain_cameras_2_0_0.json")
    func decode_from_fixture() throws {
        let data = try FixtureLoader.nestedJSON(key: "panomorph", resource: "v1_domain_cameras_2_0_0", ext: "json")
        let value = try JSONDecoder().decode(Panomorph.self, from: data)
        #expect(value.enabled == false)
        #expect(value.fisheyeCircles?.circle.isEmpty == false)
    }
}
