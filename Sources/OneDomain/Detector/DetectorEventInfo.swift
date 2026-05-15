import Foundation
import SafeEnum

/// Detector event information.
public struct DetectorEventInfo: Decodable, Equatable, Sendable {
    /// Event type.
    public enum EventType: String, Codable, Equatable, Sendable {
        case unspecified = "EVENT_TYPE_UNSPECIFIED"
        case onePhase = "ONE_PHASE_EVENT_TYPE"
        case twoPhase = "TWO_PHASE_EVENT_TYPE"
        case periodical = "PERIODICAL_EVENT_TYPE"
    }

    public let id: String
    public let name: String
    public let eventType: SafeEnum<EventType>

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case eventType = "event_type"
    }
}
