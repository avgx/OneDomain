import Foundation
import Testing
@testable import OneDomain

@Suite("CameraPrivacyMask decoding")
struct CameraPrivacyMaskDecodingTests {
    @Test("decode minimal JSON")
    func decode_minimal() throws {
        let json = """
        {"id":"mask-1","value":{}}
        """
        let value = try JSONDecoder().decode(CameraPrivacyMask.self, from: Data(json.utf8))
        #expect(value.id == "mask-1")
    }
}
