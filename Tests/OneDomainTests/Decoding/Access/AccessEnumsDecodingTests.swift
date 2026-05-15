import Foundation
import Testing
@testable import OneDomain

@Suite("Access enums decoding")
struct AccessEnumsDecodingTests {
    @Test("CameraAccess from v1_domain_cameras_1_0_4.json")
    func camera_access() throws {
        let camera = try FixtureLoader.firstCamera(resource: "v1_domain_cameras_1_0_4", ext: "json")
        #expect(camera.cameraAccess.rawValue == "CAMERA_ACCESS_FULL")
    }

    @Test("MicrophoneAccess from minimal JSON")
    func microphone_access() throws {
        let json = """
        {"access_point":"hosts/1/Microphones.1","display_name":"Mic","display_id":"1","microphone_access":"MICROPHONE_ACCESS_FULL","is_activated":true,"enabled":true}
        """
        let mic = try JSONDecoder().decode(AudioStreaming.self, from: Data(json.utf8))
        #expect(mic.microphoneAccess?.rawValue == "MICROPHONE_ACCESS_FULL")
    }

    @Test("ArchiveAccess from minimal JSON")
    func archive_access() throws {
        let json = """
        {"name":"binding","storage":"storage","is_default":true,"is_replica":false,"is_permanent":true,"has_live_sources":true,"has_replica_sources":false,"sources":[],"archive":{"access_point":"hosts/1/Archives.1","incomplete":false,"display_name":"Archive","display_id":"1","is_embedded":false,"archive_access":"ARCHIVE_ACCESS_FULL","bindings":[],"is_activated":true,"enabled":true}}
        """
        let binding = try JSONDecoder().decode(ArchiveBinding.self, from: Data(json.utf8))
        #expect(binding.archive?.archiveAccess?.rawValue == "ARCHIVE_ACCESS_FULL")
    }

    @Test("TelemetryPriority from minimal JSON")
    func telemetry_priority() throws {
        let json = """
        {"access_point":"hosts/1/Telemetry.1","display_name":"PTZ","display_id":"1","telemetry_priority":"TELEMETRY_PRIORITY_NO_ACCESS","enabled":true,"discrete_over_continuous":false,"patrol_state_control_access_point":"hosts/1/Patrol.1","is_activated":true}
        """
        let ptz = try JSONDecoder().decode(Telemetry.self, from: Data(json.utf8))
        #expect(ptz.telemetryPriority == .noAccess)
    }
}
