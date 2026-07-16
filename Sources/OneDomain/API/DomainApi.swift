import Foundation
import RequestResponse

/// Domain API (Native BL `v1/domain/*`).
public enum DomainApi {
    /// Endpoint: `GET /v1/domain/cameras`
    ///
    /// Response is SSE (`text/event-stream`) or `multipart/related` with JSON in `data` payloads.
    ///
    /// Use `pageSize` / `pageToken` to paginate large camera lists (avoids oversized multipart
    /// streams that some servers may corrupt under concurrency). Pass `CameraListPage.nextPageToken`
    /// from a chunk as `pageToken` on the next request; stop when the token is empty.
    public static func cameras(
        view: ViewMode? = nil,
        pageSize: Int? = nil,
        pageToken: String? = nil
    ) -> Request<PagedResponse<CameraListPage>> {
        var queryItems: [(String, String?)] = []

        if let view {
            queryItems.append(("view", view.rawValue))
        }
        if let pageSize {
            queryItems.append(("page_size", String(pageSize)))
        }
        if let pageToken {
            queryItems.append(("page_token", pageToken))
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
    public static func camerasBatchGet(_ body: BatchGetCamerasRequest) -> Request<PagedResponse<BatchGetCamerasResponse>> {
        Request(
            path: "v1/domain/cameras:batchGet",
            method: .post,
            body: body
        )
    }
    
    /// Endpoint: `GET /v1/domain/archives`
    ///
    /// Response is SSE (`text/event-stream`) or `multipart/related` with JSON in `data` payloads.
    public static func archives(view: ViewMode? = nil) -> Request<PagedResponse<ArchiveListPage>> {
        var queryItems: [(String, String?)] = []

        if let view {
            queryItems.append(("view", view.rawValue))
        }

        return Request(
            path: "v1/domain/archives",
            method: .get,
            query: queryItems.isEmpty ? nil : queryItems
        )
    }

}
