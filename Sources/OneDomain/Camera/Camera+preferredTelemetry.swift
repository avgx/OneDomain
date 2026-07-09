import Foundation
import OneWireFormat

extension Camera {
    public var preferredTelemetry: Telemetry? {
        ptzs?
            .filter { $0.enabled && $0.isActivated && $0.telemetryPriority?.value != .noAccess }
            .first
    }
}
