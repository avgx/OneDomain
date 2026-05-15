import Foundation
import Testing
@testable import OneDomain

@Suite("DetectorEventInfo decoding")
struct DetectorEventInfoDecodingTests {
    @Test("decode minimal JSON")
    func decode_minimal() throws {
        let json = """
        {"id":"1","name":"Event","event_type":"ONE_PHASE_EVENT_TYPE"}
        """
        let value = try JSONDecoder().decode(DetectorEventInfo.self, from: Data(json.utf8))
        #expect(value.eventType.rawValue == "ONE_PHASE_EVENT_TYPE")
    }
}
