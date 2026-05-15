import Foundation

public enum CameraAccess: String, Codable, Hashable, Sendable {
    case unspecified = "CAMERA_ACCESS_UNSPECIFIED"
    case forbid = "CAMERA_ACCESS_FORBID"
    case onlyArchive = "CAMERA_ACCESS_ONLY_ARCHIVE"
    case monitoringOnProtection = "CAMERA_ACCESS_MONITORING_ON_PROTECTION"
    case monitoring = "CAMERA_ACCESS_MONITORING"
    case archive = "CAMERA_ACCESS_ARCHIVE"
    case monitoringArchiveManage = "CAMERA_ACCESS_MONITORING_ARCHIVE_MANAGE"
    case full = "CAMERA_ACCESS_FULL"
}
