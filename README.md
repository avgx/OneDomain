# OneDomain

Swift package with **hand-written `Codable` models** and **typed HTTP request builders** for the Native BL **Domain** API (`v1/domain/*`), aligned with [`Domain.proto`](https://github.com/jerrygergov/axxon-telegram-vms/blob/main/support/protos/axxonsoft/bl/domain/Domain.proto) and validated against **real server JSON**, **SSE**, and **multipart/related** captures.

The package does **not** use protobuf code generation. Models are maintained as Swift sources so field optionality and transport quirks can follow what the server actually returns, not only what `.proto` declares.

**Platforms:** iOS 15+, macOS 13+, tvOS 17+, visionOS 1+  
**Swift tools:** 6.1+

## Dependencies

| Package | Role in OneDomain |
|---------|-------------------|
| [RequestResponse](https://github.com/avgx/RequestResponse) | `DomainApi` returns `Request<PagedResponse<T>>` for paged list/batch endpoints |
| [OneSecurity](https://github.com/avgx/OneSecurity) | `CameraAccess`, `MicrophoneAccess`, `ArchiveAccess`; `Camera.viewPolicy(for:)` |
| [SafeEnum](https://github.com/avgx/SafeEnum) | Unknown enum wire values decode without failing the whole payload (e.g. `camera_access`) |
| [EncodeDecode](https://github.com/avgx/EncodeDecode) | **Tests only** — `decodeSse`, `decodeMultipartRelated` for raw `.sse` / `.multipart` fixtures |

## What is included

### API surface (`DomainApi`)

| Method | HTTP | Response shape |
|--------|------|----------------|
| `DomainApi.cameras(view:)` | `GET /v1/domain/cameras` | `text/event-stream` (SSE) or `multipart/related` chunks of `CameraListPage` JSON |
| `DomainApi.camerasBatchGet(_:)` | `POST /v1/domain/cameras:batchGet` | SSE chunks of `BatchGetCamerasResponse` JSON |

Optional query/body `view` uses `ViewMode` (`VIEW_MODE_NO_CHILD_OBJECTS`, `VIEW_MODE_FULL`).

### Models

- **`Camera`** — main domain entity with nested streaming, archive, PTZ, detector, IO, and camera-specific fields.
- **`CameraListPage`** — list chunk: `items`, `next_page_token` (defaults to `""` when omitted).
- **`BatchGetCamerasRequest` / `BatchGetCamerasResponse`**, **`ResourceLocator`** — batch get by access points.
- Nested types grouped by folder (see [Module layout](#module-layout)).

Security types and policy live in **OneSecurity**.

### Access enums on the camera tree

From **OneSecurity** (import `OneSecurity` when naming these types explicitly):

- `CameraAccess`, `MicrophoneAccess`, `ArchiveAccess`

`TelemetryPriority` for PTZ remains in OneDomain (`PTZ/TelemetryPriority.swift`).

### Camera security policy

```swift
import OneDomain
import OneSecurity

let user = SecurityApi.makeContext(from: permissionsResponse)
let policy = camera.viewPolicy(for: user)
```

## Usage

### List cameras (app layer)

```swift
import OneDomain
import RequestResponse
import HTTP  // Get

let builder = RequestBuilder.json(baseURL: accountURL, encoder: JSONEncoder())
let pages: [CameraListPage] = try await http.pages(
    DomainApi.cameras(view: .VIEW_MODE_FULL),
    with: builder
)
let cameras = pages.flatMap(\.items)
```

`HTTPClient.pages` (Get **HTTP** module) buffers the response, picks SSE vs `multipart/related` from `Content-Type`, and decodes each chunk. Use `pages`, not `send`, for `Request<PagedResponse<…>>`.

For **tests** on raw fixtures without HTTP, use EncodeDecode directly:

```swift
let pages = try decodeSse(CameraListPage.self, from: raw, using: JSONDecoder())
// or decodeMultipartRelated(CameraListPage.self, contentType: ct, from: raw, using: decoder)
```

### Batch get

```swift
let body = BatchGetCamerasRequest(items: [
    ResourceLocator(accessPoint: "hosts/…/Cameras.1", view: .full)
])
let request = DomainApi.camerasBatchGet(body)
```

### Access point type

```swift
public typealias AccessPoint = String  // JSON key: access_point
```

## Module layout

Sources mirror proto domains and keep primitives separate:

```
Sources/OneDomain/
├── API/           DomainApi, ViewMode, AccessPoint
├── Archive/       Archive, ArchiveBinding, StorageSource, StorageType
├── BatchGet/      BatchGetCamerasRequest/Response, ResourceLocator
├── Camera/        Camera, Camera+ViewPolicy, CameraListPage, …
├── Detector/
├── IO/            Ray, Relay, SensorSignal
├── PTZ/           Telemetry, TelemetryCapabilities, TagAndTrack, …
├── Primitive/     Circle, Circles, Rectangle, OverlayColor
└── Streaming/     VideoStreaming, AudioStreaming, Speaker, …
```

Tests under `Tests/OneDomainTests/Decoding/` follow the same folder names. Shared helpers live in `Tests/OneDomainTests/Support/FixtureLoader.swift`. Captured responses are in `Tests/OneDomainTests/Resources/` (names unchanged, e.g. `v1_domain_cameras_2_0_0.json`, `v1_domain_cameras_1_0_4.multipart`).

## Optional fields and API versions

Optionality is driven by **fixture diff**, not by proto `optional` alone:

| Rule | Swift |
|------|--------|
| Key present on **1.0.4, 2.0.0, and 3.0.0** list fixtures | Non-optional `let` |
| Key appears only from **2.0.0+** | `let field: T?` |
| `next_page_token` missing or empty | `CameraListPage.nextPageToken` defaults to `""` via custom `init(from:)` |
| Unknown enum string on wire | `SafeEnum<SomeAccess>` |

**Camera core (all three list versions):**  
`access_point`, `incomplete`, `display_name`, `display_id`, `ip_address`, `camera_access`, `vendor`, `model`, `firmware`, `enabled`, `is_activated`.

**Examples of 2.0+ only (optional on `Camera`):**  
`comment`, `armed`, geo fields, `video_streams`, `microphones`, `ptzs`, `archive_bindings`, `ray`, `relay`, `detectors`, `group_ids`, `text_sources`, `speakers`, `panomorph`, `alternative_view`, buffer settings, etc.

Extra JSON keys (e.g. `search_meta_data` in multipart captures) are **not** modeled; synthesized `Decodable` ignores unknown keys.

## Tests

```bash
swift test
```

- **Unit decoding** per type, using list fixtures or minimal inline JSON where fixtures only contain empty arrays.
- **`CameraDecodingTests`** — full path: JSON lists + raw `.sse` + raw `.multipart` via EncodeDecode.
- **No live integration tests** in CI; capture new fixtures from a demo server when the API changes.

### Capturing fixtures (demo server)

```bash
# Minimal list (no body)
curl -v 'http://try.axxonsoft.com/v1/domain/cameras' -u 'root:Root1234' -X GET

# Full view (body shape may vary by server version)
curl -v 'http://try.axxonsoft.com/v1/domain/cameras' -u 'root:Root1234' -X GET \
  -d '{ "query": { "query": "*", "view": "VIEW_MODE_FULL" } }'
```

Store raw bytes for SSE/multipart as-is. For multipart, ensure each part’s `Content-Length` matches the part body.

---

## Generation prompt: hand-written Swift from `Domain.proto`

Use this spec when extending OneDomain from proto + real responses (human or LLM). **Do not** run `protoc` into this target.

### Goal

Implement Swift **iOS 15+** types for Native BL Domain API messages used by:

- `GET /v1/domain/cameras` → `ListCamerasResponse` / stream chunks → `CameraListPage`
- `POST /v1/domain/cameras:batchGet` → `BatchGetCamerasRequest`, `BatchGetCamerasResponse`

Request builders use **[RequestResponse](https://github.com/avgx/RequestResponse)** (`Request<PagedResponse<T>>`). Decoding in the app uses **[Get](https://github.com/avgx/Get)** `HTTPClient.pages`; stream framing helpers live in **[EncodeDecode](https://github.com/avgx/EncodeDecode)** (tests and low-level use).

**Proto source:**  
`https://github.com/jerrygergov/axxon-telegram-vms/blob/main/support/protos/axxonsoft/bl/domain/Domain.proto`  
(and related imports: primitives, PTZ, archive, detectors, access enums referenced from `Camera`).

### Hard rules

1. **No protobuf codegen** in the OneDomain library target.
2. **`public`** types for everything clients need; **`Sendable`** where sensible; **`Equatable`** for value types used in tests/UI.
3. **JSON keys** via `CodingKeys` with **snake_case** wire names; **one case per line**.
4. **`public typealias AccessPoint = String`** — wire field `access_point` .
5. Copy **proto `///` comments** onto Swift properties when the field maps 1:1.
6. **Do not model** `search_meta_data` or other list-only metadata not in `CodingKeys`.
7. **Security / global permissions** → [OneSecurity](https://github.com/avgx/OneSecurity); OneDomain imports access enums and adds `Camera.viewPolicy(for:)`.
8. **Folder layout** — place each message/group under:
   - `Primitive/` — `primitive.*` (Circle, Circles, Rectangle, Color → `OverlayColor`)
   - `Camera/`, `Streaming/`, `Archive/`, `PTZ/`, `Detector/`, `IO/`, `BatchGet/`, `API/`
9. **EncodeDecode** is a dependency of **OneDomainTests**, not `OneDomain`.
10. Prefer **synthesized `Decodable`**; add `init(from:)` only for defaults (e.g. empty `next_page_token`) or non-synthesizable cases.
11. **Enums** with open-ended server values → `SafeEnum<YourEnum>`; known closed sets → `String` raw `Codable` enum.
12. **Optional matrix:** compare captures from server versions **1.0.4**, **2.0.0**, **3.0.0** (and `.full` sample if needed). If a key is missing on 1.0.4 but present on 2.0.0+, use `T?`. If present on all three list fixtures, use non-optional `T`.
13. **Tests:** one `*DecodingTests.swift` per public model under `Tests/OneDomainTests/Decoding/<SameFolder>/`. Use `Bundle.module` fixtures; for SSE/multipart use raw files + `decodeSse` / `decodeMultipartRelated`. Inline minimal JSON inside test methods when fixtures have empty nested arrays. Do not add a shared `MinimalJSON` helper file unless the team agrees.
14. **Resource file names** — keep stable names: `v1_domain_cameras_<version>.json`, `.sse`, `.multipart`, `v1_domain_cameras_3_0_0.full.json`.

### Workflow

1. Read `Domain.proto` (and imports) for message/field names and comments.
2. Capture **real** responses from a lab server (JSON list, SSE, multipart) per API version.
3. Diff JSON keys across versions → optional vs required table (document in a short comment on `Camera.swift` only; no separate schema test file).
4. Implement types and `DomainApi` paths.
5. Add/fix fixtures; run `swift build && swift test`.
6. Integrate in the app via RequestResponse + Get `HTTPClient.pages` (SSE/multipart auto-detect).

### `DomainApi` pattern

```swift
public enum DomainApi {
    public static func cameras(view: ViewMode? = nil) -> Request<PagedResponse<CameraListPage>> {
        // GET v1/domain/cameras, optional ?view=
    }
    public static func camerasBatchGet(_ body: BatchGetCamerasRequest) -> Request<PagedResponse<BatchGetCamerasResponse>> {
        // POST v1/domain/cameras:batchGet, JSON body
    }
}
```

### Example property style

```swift
public struct Camera: Decodable, Equatable, Sendable, Identifiable {
    public var id: String { accessPoint }

    public let accessPoint: AccessPoint
    /// Indicates that the camera information is incomplete (the server was unable to retrieve it).
    public let incomplete: Bool?
    public let displayName: String
    // …

    public let videoStreams: [VideoStreaming]?

    private enum CodingKeys: String, CodingKey {
        case accessPoint = "access_point"
        case incomplete
        case displayName = "display_name"
        // one key per line …
        case videoStreams = "video_streams"
    }
}
```

### Integration test policy (optional)

If you add live-server tests: mark them with a tag (e.g. `.integration`) and **exclude from CI**; keep deterministic decoding tests on bundled Resources for every PR.

---

## Related work

- **OneAccount** — authentication against the same ecosystem; pairs with Get + RequestResponse.
- **Get (`dev`)** — `HTTPClient.pages` for `Request<PagedResponse<T>>`; SSE/multipart line and frame streaming in **SSE** / **Multipart** modules.

## License

See repository license (if present).
