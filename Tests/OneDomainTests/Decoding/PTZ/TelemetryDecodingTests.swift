import Foundation
import Testing
@testable import OneDomain

@Suite("Telemetry decoding")
struct TelemetryDecodingTests {
    @Test("decode minimal JSON")
    func decode_minimal() throws {
        let json = """
        {"access_point":"hosts/1/Telemetry.1","display_name":"PTZ","display_id":"1","telemetry_priority":"TELEMETRY_PRIORITY_NO_ACCESS","enabled":true,"capabilities":{"is_area_zoom_supported":true,"is_point_move_supported":true,"maximum_preset_count":16,"is_tours_supported":false},"discrete_over_continuous":false,"patrol_state_control_access_point":"hosts/1/Patrol.1","tag_and_track":{"access_point":"hosts/1/Tag.1","display_name":"Tag","display_id":"1","enabled":true},"is_activated":true}
        """
        let value = try JSONDecoder().decode(Telemetry.self, from: Data(json.utf8))
        #expect(value.accessPoint.isEmpty == false)
    }
}
