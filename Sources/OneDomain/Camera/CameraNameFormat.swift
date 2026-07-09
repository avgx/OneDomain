import Foundation

public enum CameraNameFormat: String, CaseIterable, Sendable {
    case id
    case name
    case extended
}

extension Camera {
    public func formattedName(format: CameraNameFormat) -> String {
        switch format {
        case .id:
            return displayId
        case .name:
            return displayName
        case .extended:
            return "\(displayId). \(displayName)"
        }
    }
}
