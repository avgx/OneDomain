import Foundation
import Testing
@testable import OneDomain

enum FixtureLoader {
    static func loadData(resource: String, ext: String) throws -> Data {
        let url = try #require(Bundle.module.url(forResource: resource, withExtension: ext))
        return try Data(contentsOf: url)
    }

    static func loadListPage(resource: String, ext: String, decoder: JSONDecoder = JSONDecoder()) throws -> CameraListPage {
        let data = try loadData(resource: resource, ext: ext)
        return try decoder.decode(CameraListPage.self, from: data)
    }

    static func firstCamera(resource: String, ext: String, decoder: JSONDecoder = JSONDecoder()) throws -> Camera {
        let page = try loadListPage(resource: resource, ext: ext, decoder: decoder)
        return try #require(page.items.first)
    }

    /// JSON for `items[0]` from a list fixture.
    static func firstCameraJSON(resource: String, ext: String) throws -> Data {
        let root = try loadJSONObject(resource: resource, ext: ext)
        let items = try #require(root["items"] as? [[String: Any]])
        let first = try #require(items.first)
        return try JSONSerialization.data(withJSONObject: first)
    }

    /// Extracts a nested value from the first camera in a list fixture as JSON `Data`.
    /// - Parameter parentKey: When set, reads `first[parentKey][key]` (e.g. `panomorph` → `fisheye_circles`).
    static func nestedJSON(
        key: String,
        resource: String,
        ext: String,
        parentKey: String? = nil
    ) throws -> Data {
        let root = try loadJSONObject(resource: resource, ext: ext)
        let items = try #require(root["items"] as? [[String: Any]])
        var object = try #require(items.first)
        if let parentKey {
            object = try #require(object[parentKey] as? [String: Any])
        }
        let value = try #require(object[key])
        return try JSONSerialization.data(withJSONObject: value)
    }

    private static func loadJSONObject(resource: String, ext: String) throws -> [String: Any] {
        let data = try loadData(resource: resource, ext: ext)
        let object = try JSONSerialization.jsonObject(with: data)
        return try #require(object as? [String: Any])
    }
}
