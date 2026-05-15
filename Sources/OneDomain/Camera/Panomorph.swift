import Foundation

/// Panomorph mode.
public struct Panomorph: Decodable, Equatable, Sendable {
    public let enabled: Bool
    public let fitToFrame: Bool
    public let cameraPosition: Int
    public let viewType: Int
    public let cameraLens: String
    public let fisheyeCircles: Circles?

    private enum CodingKeys: String, CodingKey {
        case enabled
        case fitToFrame = "fit_to_frame"
        case cameraPosition = "camera_position"
        case viewType = "view_type"
        case cameraLens = "camera_lens"
        case fisheyeCircles = "fisheye_circles"
    }
}
