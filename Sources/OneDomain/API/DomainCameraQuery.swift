import Foundation

/// `SearchQuery` for `GET /v1/domain/cameras` (`ListCamerasRequest.query`).
///
/// grpc-gateway maps the nested message to `query.query`, `query.search_fields`, and
/// `query.search_type`. When `fields` is empty the server searches `DECORATED_NAME`.
public struct DomainCameraQuery: Sendable, Equatable {
    public var text: String
    public var fields: [Field]
    public var type: SearchType

    public init(
        text: String,
        fields: [Field] = [],
        type: SearchType = .substring
    ) {
        self.text = text
        self.fields = fields
        self.type = type
    }

    /// Lookup of a single camera. Decorated-name search does not match an access point.
    public static func accessPoint(_ accessPoint: String) -> DomainCameraQuery {
        DomainCameraQuery(text: accessPoint, fields: [.accessPoint], type: .substring)
    }

    var queryItems: [(String, String?)] {
        var items: [(String, String?)] = [("query.query", text)]
        for field in fields {
            items.append(("query.search_fields", field.rawValue))
        }
        items.append(("query.search_type", type.rawValue))
        return items
    }

    public enum Field: String, Sendable, Equatable {
        case decoratedName = "DECORATED_NAME"
        case displayName = "DISPLAY_NAME"
        case displayId = "DISPLAY_ID"
        case comment = "COMMENT"
        case accessPoint = "ACCESS_POINT"
    }

    public enum SearchType: String, Sendable, Equatable {
        case substring = "SUBSTRING"
        case fuzzy = "FUZZY"
    }
}
