import Foundation

public enum ArchiveAccess: String, Codable, Hashable, Sendable {
    case unspecified = "ARCHIVE_ACCESS_UNSPECIFIED"
    case forbid = "ARCHIVE_ACCESS_FORBID"
    case full = "ARCHIVE_ACCESS_FULL"
}
