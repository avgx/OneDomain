import Foundation

/// Sensor signal.
public struct SensorSignal: Codable, Equatable, Sendable {
    /// Signal range.
    public struct Range: Codable, Equatable, Sendable {
        public let min: Double
        public let max: Double

        private enum CodingKeys: String, CodingKey {
            case min
            case max
        }
    }

    public let name: String
    public let levelLimits: Range?
    public let precision: Int
    public let measurementUnit: String

    private enum CodingKeys: String, CodingKey {
        case name
        case levelLimits = "level_limits"
        case precision
        case measurementUnit = "measurement_unit"
    }
}
