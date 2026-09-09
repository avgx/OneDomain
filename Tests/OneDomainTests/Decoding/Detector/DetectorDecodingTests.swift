import Foundation
import Testing
@testable import OneDomain

@Suite("Detector decoding")
struct DetectorDecodingTests {
    @Test("decode without storyboard")
    func decode_without_storyboard() throws {
        let json = """
        {"access_point":"hosts/1/Detectors.1","display_name":"Detector","display_id":"1","parent_detector":"","type":"t","type_name":"Type","is_activated":true,"groups":[],"scene_descriptions":[],"events":[],"enabled":true,"is_realtime_recognition_enabled":false,"is_recording_objects_tracking_enabled":false}
        """
        let value = try JSONDecoder().decode(Detector.self, from: Data(json.utf8))
        #expect(value.storyboard == nil)
    }

    @Test("decode minimal JSON")
    func decode_minimal() throws {
        let json = """
        {"access_point":"hosts/1/Detectors.1","display_name":"Detector","display_id":"1","parent_detector":"hosts/1/Parent.1","type":"t","type_name":"Type","is_activated":true,"groups":[],"scene_descriptions":[{"access_point":"hosts/1/Scene.1","mimetype":"image/jpeg"}],"events":[{"id":"1","name":"Event","event_type":"ONE_PHASE_EVENT_TYPE"}],"enabled":true,"is_realtime_recognition_enabled":false,"is_recording_objects_tracking_enabled":false,"storyboard":"sb"}
        """
        let value = try JSONDecoder().decode(Detector.self, from: Data(json.utf8))
        #expect(value.accessPoint.isEmpty == false)
    }

    @Test("legacy next detector omits type typeName groups enabled mimetype")
    func decode_legacy_next_omitted_optional_fields() throws {
        let json = """
        {"access_point":"hosts/SERVERMKD001/AVDetector.1/EventSupplier","display_name":"Детектор движения","display_id":"1","parent_detector":"","is_activated":true,"scene_descriptions":[{"access_point":"hosts/SERVERMKD001/AVDetector.1/SourceEndpoint.mask"},{"access_point":"hosts/SERVERMKD001/AVDetector.1/SourceEndpoint.vmda"}],"events":[{"id":"MotionDetected","name":"","event_type":"TWO_PHASE_EVENT_TYPE"},{"id":"MotionMask","name":"","event_type":"PERIODICAL_EVENT_TYPE"},{"id":"TargetList","name":"","event_type":"PERIODICAL_EVENT_TYPE"}]}
        """
        let value = try JSONDecoder().decode(Detector.self, from: Data(json.utf8))
        #expect(value.type == nil)
        #expect(value.typeName == nil)
        #expect(value.groups == nil)
        #expect(value.enabled == nil)
        #expect(value.sceneDescriptions.count == 2)
        #expect(value.sceneDescriptions[0].mimetype == nil)
        #expect(value.sceneDescriptions[1].mimetype == nil)
        #expect(value.events.count == 3)
        #expect(value.events[0].eventType.value == .twoPhase)
        #expect(value.parentDetector?.isEmpty == true)
    }
    
    @Test("parent_detector empty string decodes as empty not nil")
    func parent_detector_empty_string() throws {
        let json = """
        {"access_point":"hosts/1/Detectors.1","display_name":"Detector","display_id":"1","parent_detector":"","type":"t","type_name":"Type","is_activated":true,"groups":[],"scene_descriptions":[],"events":[],"enabled":true}
        """
        let value = try JSONDecoder().decode(Detector.self, from: Data(json.utf8))
        #expect(value.parentDetector != nil)
        #expect(value.parentDetector?.isEmpty == true)
    }

    @Test("parent_detector absent decodes as nil")
    func parent_detector_absent() throws {
        let json = """
        {"access_point":"hosts/1/Detectors.1","display_name":"Detector","display_id":"1","type":"t","type_name":"Type","is_activated":true,"groups":[],"scene_descriptions":[],"events":[],"enabled":true}
        """
        let value = try JSONDecoder().decode(Detector.self, from: Data(json.utf8))
        #expect(value.parentDetector == nil)
    }
}
