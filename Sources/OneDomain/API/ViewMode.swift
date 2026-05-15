import Foundation

/// View mode options for domain cameras.
public enum ViewMode: String, Codable, Equatable, Sendable {
    /// Server response includes only basic camera or archive info, with no sub components
    case VIEW_MODE_NO_CHILD_OBJECTS = "VIEW_MODE_NO_CHILD_OBJECTS"
    /// Full representation of a camera or an archive with all sub-components.
    case VIEW_MODE_FULL = "VIEW_MODE_FULL"
}
