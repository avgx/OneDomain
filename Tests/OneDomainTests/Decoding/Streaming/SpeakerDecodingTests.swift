import Foundation
import Testing
@testable import OneDomain

@Suite("Speaker decoding")
struct SpeakerDecodingTests {
    @Test("decode minimal JSON")
    func decode_minimal() throws {
        let json = """
        {"access_point":"hosts/1/Speakers.1","display_name":"Speaker","display_id":"1","is_activated":true,"enabled":true,"tracks":[{"state_control_ap":"hosts/1/State.1"}]}
        """
        let value = try JSONDecoder().decode(Speaker.self, from: Data(json.utf8))
        #expect(value.accessPoint?.isEmpty == false)
    }
}
