import Foundation
import Testing
@testable import OneDomain

@Suite("Detector decoding")
struct DetectorDecodingTests {
    @Test("decode minimal JSON")
    func decode_minimal() throws {
        let json = """
        {"access_point":"hosts/1/Detectors.1","display_name":"Detector","display_id":"1","parent_detector":"hosts/1/Parent.1","type":"t","type_name":"Type","is_activated":true,"groups":[],"scene_descriptions":[{"access_point":"hosts/1/Scene.1","mimetype":"image/jpeg"}],"events":[{"id":"1","name":"Event","event_type":"ONE_PHASE_EVENT_TYPE"}],"enabled":true,"is_realtime_recognition_enabled":false,"is_recording_objects_tracking_enabled":false,"storyboard":"sb"}
        """
        let value = try JSONDecoder().decode(Detector.self, from: Data(json.utf8))
        #expect(value.accessPoint.isEmpty == false)
    }
}
