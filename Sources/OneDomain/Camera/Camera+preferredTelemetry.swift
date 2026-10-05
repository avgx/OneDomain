import Foundation
import OneWireFormat

extension Camera {
    public var preferredTelemetry: Telemetry? {
        ptzs?
            .filter { ($0.enabled ?? true) && ($0.isActivated ?? true) && $0.telemetryPriority?.value != .noAccess }
            .first
    }
}
