import Foundation
import Testing
@testable import OneDomain

@Suite("AudioStreaming decoding")
struct AudioStreamingDecodingTests {
    @Test("decode minimal JSON")
    func decode_minimal() throws {
        let json = """
        {"access_point":"hosts/1/Microphones.1","display_name":"Mic","display_id":"1","microphone_access":"MICROPHONE_ACCESS_FULL","is_activated":true,"enabled":true}
        """
        let value = try JSONDecoder().decode(AudioStreaming.self, from: Data(json.utf8))
        #expect(value.accessPoint.isEmpty == false)
    }
}
