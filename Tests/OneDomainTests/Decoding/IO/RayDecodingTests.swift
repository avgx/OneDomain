import Foundation
import Testing
@testable import OneDomain

@Suite("Ray decoding")
struct RayDecodingTests {
    @Test("decode minimal JSON")
    func decode_minimal() throws {
        let json = """
        {"access_point":"hosts/1/Rays.1","display_name":"Ray","display_id":"1","is_activated":true,"enabled":true}
        """
        let value = try JSONDecoder().decode(Ray.self, from: Data(json.utf8))
        #expect(value.accessPoint == "hosts/1/Rays.1")
    }
}
