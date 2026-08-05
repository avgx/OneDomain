import Foundation
import OneWireFormat

/// VMDA metadata packet payload (WS type 2).
public struct VmdaData: Codable, Equatable, Sendable {
    public let isPrivacyDetectorInfo: Bool
    /// ASIP wire timestamp (`yyyyMMddTHHmmss.SSSSSS`).
    public let timestamp: String
    public let tracklets: [Tracklet]

    private enum CodingKeys: String, CodingKey {
        case isPrivacyDetectorInfo = "is_privacy_detector_info"
        case timestamp
        case tracklets
    }

    /// Parsed ASIP timestamp when the wire value is a non-empty valid ASIP string.
    public var timestampDate: Date? {
        guard !timestamp.isEmpty else { return nil }
        return Timestamp.utc.date(from: timestamp)
    }

    public static func decode(from data: Data) -> VmdaData? {
        try? JSONDecoder().decode(VmdaData.self, from: data)
    }
}

/// Archive metadata container wrapping VMDA entries.
public struct VmdaDataContainer: Codable, Equatable, Sendable {
    public let vmda: [VmdaData]
}
