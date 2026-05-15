import Foundation
import SafeEnum

// Было в SchemaContractTests `domainCamerasFieldEvolution`:
// Общие ключи 1.0.4 ∩ 2.0.0 ∩ 3.0.0 (11): access_point, camera_access, display_id, display_name,
// enabled, firmware, incomplete, ip_address, is_activated, model, vendor → non-optional.
// С 2.0.0 добавляются остальные ключи (alternative_view, video_streams, panomorph, …) → Optional.
// 3.0.0 default list: новых ключей camera относительно 2.0.0 нет.

/// Camera configuration.
public struct Camera: Decodable, Equatable, Sendable, Identifiable {
    public var id: String { accessPoint }

    public let accessPoint: AccessPoint
    /// Indicates that the camera information is incomplete (the server was unable to retrieve it).
    public let incomplete: Bool
    public let displayName: String
    public let displayId: String
    public let ipAddress: String
    public let cameraAccess: SafeEnum<CameraAccess>
    public let vendor: String
    public let model: String
    public let firmware: String
    public let enabled: Bool
    public let isActivated: Bool

    public let comment: String?
    public let armed: Bool?
    public let geoLocationLatitude: String?
    public let geoLocationLongitude: String?
    public let geoLocationAzimuth: String?
    public let breaksUnusedConnections: Bool?
    public let serialNumber: String?
    public let videoStreams: [VideoStreaming]?
    public let microphones: [AudioStreaming]?
    public let ptzs: [Telemetry]?
    public let archiveBindings: [ArchiveBinding]?
    public let ray: [Ray]?
    public let relay: [Relay]?
    /// Live detectors.
    public let detectors: [Detector]?
    /// Offline analytics.
    public let offlineDetectors: [Detector]?
    public let groupIds: [String]?
    public let textSources: [TextSource]?
    public let speakers: [Speaker]?
    public let panomorph: Panomorph?
    public let videoBufferSize: Int?
    public let videoBufferEnabled: Bool?
    public let alternativeView: AlternativeView?

    /// Full model name.
    public let modelDisplayName: String?
    /// Has access to any (not embedded!) archive binding.
    public let hasArchiveBindings: Bool?
    /// The type of camera (e.g. bullet, speed_dome, fix_dome).
    public let type: String?
    public let privacyMask: [CameraPrivacyMask]?
    /// Collection of text overlays to be displayed over current camera's video streams.
    public let overlayTextSettings: OverlayTextSettings?

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case incomplete
        case displayName = "display_name"
        case displayId = "display_id"
        case ipAddress = "ip_address"
        case cameraAccess = "camera_access"
        case vendor
        case model
        case modelDisplayName = "model_display_name"
        case firmware
        case comment
        case armed
        case geoLocationLatitude = "geo_location_latitude"
        case geoLocationLongitude = "geo_location_longitude"
        case geoLocationAzimuth = "geo_location_azimuth"
        case breaksUnusedConnections = "breaks_unused_connections"
        case serialNumber = "serial_number"
        case videoStreams = "video_streams"
        case microphones
        case ptzs
        case hasArchiveBindings = "has_archive_bindings"
        case archiveBindings = "archive_bindings"
        case ray
        case relay
        case detectors
        case offlineDetectors = "offline_detectors"
        case groupIds = "group_ids"
        case isActivated = "is_activated"
        case textSources = "text_sources"
        case speakers
        case enabled
        case panomorph
        case videoBufferSize = "video_buffer_size"
        case videoBufferEnabled = "video_buffer_enabled"
        case alternativeView = "alternative_view"
        case type
        case privacyMask = "privacy_mask"
        case overlayTextSettings = "overlay_text_settings"
    }
}
