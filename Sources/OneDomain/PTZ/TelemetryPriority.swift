import Foundation

public enum TelemetryPriority: String, Codable, Hashable, Sendable {
    case unspecified = "TELEMETRY_PRIORITY_UNSPECIFIED"
    case noAccess = "TELEMETRY_PRIORITY_NO_ACCESS"
    case highest = "TELEMETRY_PRIORITY_HIGHEST"
}
