import Foundation
import Testing
@testable import OneDomain

@Suite("OverlayTextSettings decoding")
struct OverlayTextSettingsDecodingTests {
    @Test("decode minimal JSON")
    func decode_minimal() throws {
        let json = """
        {"texts":[{"text":"Hello","rectangle":{"x":0.1,"y":0.2,"w":0.3,"h":0.1},"color":{"red":255,"green":0,"blue":0,"alpha":128}}]}
        """
        let value = try JSONDecoder().decode(OverlayTextSettings.self, from: Data(json.utf8))
        #expect(value.texts?.first?.text == "Hello")
    }
}
