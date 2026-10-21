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
    
    @Test("decode without enabled")
    func decode_no_enabled() throws {
        let json = """
        {"access_point":"hosts/BDS-NVR1/DeviceIpint.61/SourceEndpoint.textEvent:0","display_name":"Event source - St12 Wholesale","display_id":"0"}
        """
        let value = try JSONDecoder().decode(TextSource.self, from: Data(json.utf8))
        #expect(value.accessPoint == "hosts/BDS-NVR1/DeviceIpint.61/SourceEndpoint.textEvent:0")
        #expect(value.displayName == "Event source - St12 Wholesale")
        #expect(value.displayId == "0")
        #expect(value.enabled == nil)
    }
}
