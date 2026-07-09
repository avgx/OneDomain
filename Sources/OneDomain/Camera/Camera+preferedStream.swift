import Foundation
import OneWireFormat

extension Camera {
    public var preferredStream: AccessPoint? {
        if let activated = videoStreams?.first(where: \.isActivated)?.streamAcessPoint {
            return activated
        }
        if let enabled = videoStreams?.first(where: \.enabled)?.streamAcessPoint {
            return enabled
        }
        return videoStreams?.first?.streamAcessPoint
    }
}
