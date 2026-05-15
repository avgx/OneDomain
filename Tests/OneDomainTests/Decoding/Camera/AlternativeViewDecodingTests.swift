import Foundation
import Testing
@testable import OneDomain

@Suite("AlternativeView decoding")
struct AlternativeViewDecodingTests {
    @Test("decode from v1_domain_cameras_2_0_0.json")
    func decode_from_fixture() throws {
        let data = try FixtureLoader.nestedJSON(key: "alternative_view", resource: "v1_domain_cameras_2_0_0", ext: "json")
        let value = try JSONDecoder().decode(AlternativeView.self, from: data)
        #expect(value.alternativeCameraName == "")
        #expect(value.secondAlternativeCameraName == "")
    }
}
