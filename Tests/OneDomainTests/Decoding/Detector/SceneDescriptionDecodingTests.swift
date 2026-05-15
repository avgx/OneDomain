import Foundation
import Testing
@testable import OneDomain

@Suite("SceneDescription decoding")
struct SceneDescriptionDecodingTests {
    @Test("decode minimal JSON")
    func decode_minimal() throws {
        let json = """
        {"access_point":"hosts/1/Scene.1","mimetype":"image/jpeg"}
        """
        let value = try JSONDecoder().decode(SceneDescription.self, from: Data(json.utf8))
        #expect(value.mimetype == "image/jpeg")
    }
}
