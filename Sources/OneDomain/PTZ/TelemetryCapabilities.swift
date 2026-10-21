import Foundation

/// Telemetry capabilities.
///
/// Source: `Domain.proto` `TelemetryCapabilities`. Move, focus, zoom, and iris
/// reuse `PtzCapabilities`; `limits` values reuse `PtzLimits`.
public struct TelemetryCapabilities: Codable, Equatable, Sendable {
    public let moveSupported: PtzCapabilities?
    public let focusSupported: PtzCapabilities?
    public let zoomSupported: PtzCapabilities?
    public let irisSupported: PtzCapabilities?
    public let isAreaZoomSupported: Bool?
    public let isPointMoveSupported: Bool?
    public let maximumPresetCount: Int?
    public let isToursSupported: Bool?
    /// Per-axis ranges. Keys are `PtzFreedom` raw values.
    public let limits: [Int: PtzLimits]?

    public func limits(for freedom: PtzFreedom) -> PtzLimits? {
        limits?[freedom.rawValue]
    }

    private enum CodingKeys: String, CodingKey {
        case moveSupported = "move_supported"
        case focusSupported = "focus_supported"
        case zoomSupported = "zoom_supported"
        case irisSupported = "iris_supported"
        case isAreaZoomSupported = "is_area_zoom_supported"
        case isPointMoveSupported = "is_point_move_supported"
        case maximumPresetCount = "maximum_preset_count"
        case isToursSupported = "is_tours_supported"
        case limits
    }
}
