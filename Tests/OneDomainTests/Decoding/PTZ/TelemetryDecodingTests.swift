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
        #expect(value.capabilities?.moveSupported == nil)
        #expect(value.capabilities?.limits == nil)
    }

    @Test("decode ONVIF generic telemetry with focus and zoom limits")
    func decode_onvif_generic_focus_and_zoom() throws {
        let json = """
        {
          "access_point": "hosts/NVR1/DeviceIpint.1/TelemetryControl.0",
          "display_name": "",
          "display_id": "0",
          "telemetry_priority": "TELEMETRY_PRIORITY_HIGHEST",
          "capabilities": {
            "move_supported": {
              "is_relative": false,
              "is_continuous": false,
              "is_absolute": false,
              "is_auto": false
            },
            "focus_supported": {
              "is_relative": true,
              "is_continuous": true,
              "is_absolute": false,
              "is_auto": false
            },
            "zoom_supported": {
              "is_relative": true,
              "is_continuous": true,
              "is_absolute": true,
              "is_auto": false
            },
            "iris_supported": {
              "is_relative": false,
              "is_continuous": false,
              "is_absolute": false,
              "is_auto": false
            },
            "is_area_zoom_supported": false,
            "is_point_move_supported": false,
            "maximum_preset_count": 0,
            "is_tours_supported": false,
            "limits": {
              "3": {
                "relative_step": { "min": 0, "max": 100 },
                "continuous_speed": { "min": 0, "max": 100 },
                "absolute_position": { "min": 0, "max": 10000 }
              },
              "2": {
                "relative_step": { "min": 0, "max": 100 },
                "continuous_speed": { "min": 0, "max": 100 }
              }
            }
          },
          "is_activated": true
        }
        """
        let value = try JSONDecoder().decode(Telemetry.self, from: Data(json.utf8))
        #expect(value.accessPoint == "hosts/NVR1/DeviceIpint.1/TelemetryControl.0")
        #expect(value.displayName.isEmpty)
        #expect(value.displayId == "0")
        #expect(value.telemetryPriority?.value == .highest)
        #expect(value.enabled == nil)
        #expect(value.isActivated == true)
        #expect(value.discreteOverContinuous == nil)

        let capabilities = try #require(value.capabilities)
        #expect(capabilities.isAreaZoomSupported == false)
        #expect(capabilities.isPointMoveSupported == false)
        #expect(capabilities.maximumPresetCount == 0)
        #expect(capabilities.isToursSupported == false)

        let move = try #require(capabilities.moveSupported)
        #expect(move.isRelative == false)
        #expect(move.isContinuous == false)
        #expect(move.isAbsolute == false)
        #expect(move.isAuto == false)

        let focus = try #require(capabilities.focusSupported)
        #expect(focus.isRelative == true)
        #expect(focus.isContinuous == true)
        #expect(focus.isAbsolute == false)
        #expect(focus.isAuto == false)

        let zoom = try #require(capabilities.zoomSupported)
        #expect(zoom.isRelative == true)
        #expect(zoom.isContinuous == true)
        #expect(zoom.isAbsolute == true)
        #expect(zoom.isAuto == false)

        let iris = try #require(capabilities.irisSupported)
        #expect(iris.isRelative == false)
        #expect(iris.isContinuous == false)
        #expect(iris.isAbsolute == false)
        #expect(iris.isAuto == false)

        #expect(capabilities.limits?.count == 2)
        #expect(capabilities.limits(for: .pan) == nil)
        #expect(capabilities.limits(for: .tilt) == nil)
        #expect(capabilities.limits(for: .iris) == nil)

        let focusLimits = try #require(capabilities.limits(for: .focus))
        #expect(focusLimits.relativeStep == PtzRange(min: 0, max: 100))
        #expect(focusLimits.continuousSpeed == PtzRange(min: 0, max: 100))
        #expect(focusLimits.absolutePosition == nil)

        let zoomLimits = try #require(capabilities.limits(for: .zoom))
        #expect(zoomLimits.relativeStep == PtzRange(min: 0, max: 100))
        #expect(zoomLimits.continuousSpeed == PtzRange(min: 0, max: 100))
        #expect(zoomLimits.absolutePosition == PtzRange(min: 0, max: 10000))
    }
}
