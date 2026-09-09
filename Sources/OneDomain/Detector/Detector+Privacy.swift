import Foundation

extension Detector {
    /// Privacy-shield / masking-object detector that emits dynamic privacy masks over WS.
    public var isPrivacy: Bool {
        type == "PrivacyShieldDetector"
            || type == "MaskingObject"
            || events.contains { $0.id == "PrivateMask" }
    }

    /// Activated privacy detector that requires WS sideband mask packets.
    public var isActivePrivacy: Bool {
        isActivated && (enabled ?? true) && isPrivacy
    }
}
