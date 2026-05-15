import Foundation

/// Telemetry capabilities.
public struct TelemetryCapabilities: Codable, Equatable, Sendable {
    public let isAreaZoomSupported: Bool
    public let isPointMoveSupported: Bool
    public let maximumPresetCount: Int
    public let isToursSupported: Bool

    private enum CodingKeys: String, CodingKey {
        case isAreaZoomSupported = "is_area_zoom_supported"
        case isPointMoveSupported = "is_point_move_supported"
        case maximumPresetCount = "maximum_preset_count"
        case isToursSupported = "is_tours_supported"
    }
}
