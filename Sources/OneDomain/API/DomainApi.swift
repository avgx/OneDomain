import Foundation
import RequestResponse

/// Domain API (Native BL `v1/domain/*`).
public enum DomainApi {
    /// Endpoint: `GET /v1/domain/cameras`
    ///
    /// Response is SSE (`text/event-stream`) or `multipart/related` with JSON in `data` payloads.
    public static func cameras(view: ViewMode? = nil) -> Request<Data> {
        var queryItems: [(String, String?)] = []

        if let view {
            queryItems.append(("view", view.rawValue))
        }

        return Request(
            path: "v1/domain/cameras",
            method: .get,
            query: queryItems.isEmpty ? nil : queryItems
        )
    }

    /// Endpoint: `POST /v1/domain/cameras:batchGet`
    ///
    /// Response is SSE with JSON payloads in `data` lines.
    public static func camerasBatchGet(_ body: BatchGetCamerasRequest) -> Request<Data> {
        Request(
            path: "v1/domain/cameras:batchGet",
            method: .post,
            body: body
        )
    }
}
