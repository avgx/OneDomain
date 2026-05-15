import Foundation
import Testing
@testable import OneDomain

@Suite("VideoStreaming decoding")
struct VideoStreamingDecodingTests {
    @Test("decode minimal JSON")
    func decode_minimal() throws {
        let json = """
        {"stream_acess_point":"hosts/1/Streaming.1","decoder_acess_point":"hosts/1/Decoders.1","enabled":true,"display_name":"Main","display_id":"1","fps":25,"is_activated":true}
        """
        let value = try JSONDecoder().decode(VideoStreaming.self, from: Data(json.utf8))
        #expect(value.streamAcessPoint.isEmpty == false)
    }
}
