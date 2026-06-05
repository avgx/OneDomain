import Foundation
import SafeEnum

public enum CameraPosition: Int, Identifiable, CaseIterable, Codable, Sendable {
    case wall = 0
    case ceiling = 1
    case ground = 2
    
    public var id: Int { rawValue }
}
