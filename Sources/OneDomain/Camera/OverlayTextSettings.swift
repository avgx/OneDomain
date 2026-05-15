import Foundation

/// Collection of text overlays to be displayed over current camera's video streams.
public struct OverlayTextSettings: Decodable, Equatable, Sendable {
    public let texts: [OverlayText]?

    private enum CodingKeys: String, CodingKey {
        case texts
    }
}

/// Plain text overlay on a video frame.
public struct OverlayText: Decodable, Equatable, Sendable {
    /// Plain text to be displayed.
    public let text: String?
    /// Position of the text on the video frame in relative coordinates ([0, 1]).
    public let rectangle: Rectangle?
    public let color: OverlayColor?

    private enum CodingKeys: String, CodingKey {
        case text
        case rectangle
        case color
    }
}
