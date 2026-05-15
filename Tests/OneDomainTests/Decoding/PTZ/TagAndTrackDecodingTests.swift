import Foundation
import Testing
@testable import OneDomain

@Suite("TagAndTrack decoding")
struct TagAndTrackDecodingTests {
    @Test("decode minimal JSON")
    func decode_minimal() throws {
        let json = """
        {"access_point":"hosts/1/Tag.1","display_name":"Tag","display_id":"1","enabled":true}
        """
        let value = try JSONDecoder().decode(TagAndTrack.self, from: Data(json.utf8))
        #expect(value.enabled == true)
    }
}
