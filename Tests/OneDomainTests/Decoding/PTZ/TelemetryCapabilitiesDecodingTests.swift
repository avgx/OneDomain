import Foundation
import Testing
@testable import OneDomain

@Suite("TelemetryCapabilities decoding")
struct TelemetryCapabilitiesDecodingTests {
    @Test("decode minimal JSON")
    func decode_minimal() throws {
        let json = """
        {"is_area_zoom_supported":true,"is_point_move_supported":true,"maximum_preset_count":16,"is_tours_supported":false}
        """
        let value = try JSONDecoder().decode(TelemetryCapabilities.self, from: Data(json.utf8))
        #expect(value.maximumPresetCount == 16)
    }
}
