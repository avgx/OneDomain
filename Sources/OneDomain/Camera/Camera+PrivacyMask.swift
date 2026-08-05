import Foundation

extension Camera {
    /// Non-empty server-configured static privacy polygons.
    public var hasStaticPrivacyMask: Bool {
        guard let privacyMask, !privacyMask.isEmpty else { return false }
        return privacyMask.contains { mask in
            guard let value = mask.value else { return false }
            return !value.normalizedPoints.isEmpty
        }
    }

    /// Dynamic privacy mask capability from live/offline detectors.
    public var hasDynamicPrivacyMask: Bool {
        let live = detectors?.contains(where: \.isActivePrivacy) ?? false
        let offline = offlineDetectors?.contains(where: \.isActivePrivacy) ?? false
        return live || offline
    }

    /// Static mask polygons with geometry suitable for rendering.
    public var staticPrivacyMasks: [CameraPrivacyMask.PrivacyMask] {
        (privacyMask ?? []).compactMap(\.value).filter { !$0.normalizedPoints.isEmpty }
    }

    /// Masks or tracks over WS require fMP4 WebSocket (HTTP fMP4 is malformed for sideband sessions).
    public var requiresWebSocketMedia: Bool {
        hasDynamicPrivacyMask
    }
}
