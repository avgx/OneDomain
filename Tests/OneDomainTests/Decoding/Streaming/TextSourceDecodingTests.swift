import Foundation
import Testing
@testable import OneDomain

@Suite("TextSource decoding")
struct TextSourceDecodingTests {
    @Test("decode minimal JSON")
    func decode_minimal() throws {
        let json = """
        {"access_point":"hosts/1/TextSources.1","display_name":"Text","display_id":"1","enabled":true}
        """
        let value = try JSONDecoder().decode(TextSource.self, from: Data(json.utf8))
        #expect(value.accessPoint.isEmpty == false)
    }
}
