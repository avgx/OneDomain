import Foundation

/// Detector configuration.
public struct Detector: Decodable, Equatable, Sendable, Identifiable {
    public var id: String { accessPoint }

    public let accessPoint: AccessPoint
    public let displayName: String
    public let displayId: String
    public let parentDetector: AccessPoint
    public let type: String
    public let typeName: String
    public let isActivated: Bool
    public let groups: [String]
    public let sceneDescriptions: [SceneDescription]
    public let events: [DetectorEventInfo]
    public let enabled: Bool
    public let isRealtimeRecognitionEnabled: Bool
    public let isRecordingObjectsTrackingEnabled: Bool
    /// Endpoint of the event frame stream.
    public let storyboard: String
    /// Shows whether face detector build biometric vectors.
    public let isBiometricRecognitionEnabled: Bool?
    /// Shows whether neurotracker determines color of objects.
    public let isColorRecognitionEnabled: Bool?
    /// Whether to compare vectors with specified prompts or only save to DB.
    public let reportImageDescriptor: Bool?

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case displayName = "display_name"
        case displayId = "display_id"
        case parentDetector = "parent_detector"
        case type
        case typeName = "type_name"
        case isActivated = "is_activated"
        case groups
        case sceneDescriptions = "scene_descriptions"
        case events
        case enabled
        case isRealtimeRecognitionEnabled = "is_realtime_recognition_enabled"
        case isRecordingObjectsTrackingEnabled = "is_recording_objects_tracking_enabled"
        case storyboard
        case isBiometricRecognitionEnabled = "is_biometric_recognition_enabled"
        case isColorRecognitionEnabled = "is_color_recognition_enabled"
        case reportImageDescriptor = "report_image_descriptor"
    }
}
