import Foundation
import Testing
@testable import OneDomain

@Suite("Relay decoding")
struct RelayDecodingTests {
    @Test("decode minimal JSON")
    func decode_minimal() throws {
        let json = """
        {"access_point":"hosts/1/Relays.1","display_name":"Relay","display_id":"1","is_activated":true,"enabled":true}
        """
        let value = try JSONDecoder().decode(Relay.self, from: Data(json.utf8))
        #expect(value.accessPoint == "hosts/1/Relays.1")
    }
}
