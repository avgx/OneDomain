import EncodeDecode
import Foundation
import Testing
@testable import OneDomain

@Suite("Archive decoding")
struct ArchiveDecodingTests {
    private let decoder = JSONDecoder()

    @Test("decode from minimal archive binding")
    func decode_from_fixture() throws {
        let json = """
        {"name":"binding","storage":"storage","is_default":true,"is_replica":false,"is_permanent":true,"has_live_sources":true,"has_replica_sources":false,"sources":[],"archive":{"access_point":"hosts/1/Archives.1","incomplete":false,"display_name":"Archive","display_id":"1","is_embedded":false,"archive_access":"ARCHIVE_ACCESS_FULL","bindings":[],"is_activated":true,"enabled":true}}
        """
        let binding = try decoder.decode(ArchiveBinding.self, from: Data(json.utf8))
        let archive = try #require(binding.archive)
        #expect(archive.accessPoint.isEmpty == false)
    }

    @Test("decode embedded archive from VIEW_MODE_FULL SSE")
    func decode_embedded_from_full_sse() throws {
        let raw = try FixtureLoader.loadData(resource: "v1_domain_archives_2_10_0_full", ext: "sse")
        let pages = try decodeSse(ArchiveListPage.self, from: raw, using: decoder)
        let archive = try #require(pages.first?.items.first)
        #expect(archive.isEmbedded == true)
        #expect(archive.accessPoint.contains("/MultimediaStorage.0"))
        #expect(archive.bindings.first?.camera != nil)
        #expect(archive.bindings.first?.archive == nil)
        #expect(archive.storageType == nil)
    }

    @Test("decode central archive with UUID sources from VIEW_MODE_FULL SSE")
    func decode_central_from_full_sse() throws {
        let raw = try FixtureLoader.loadData(resource: "v1_domain_archives_2_10_0_full", ext: "sse")
        let pages = try decodeSse(ArchiveListPage.self, from: raw, using: decoder)
        let archive = try #require(pages.first?.items.last)
        #expect(archive.isEmbedded == false)
        #expect(archive.bindings.count == 2)
        let uuidSource = archive.bindings.flatMap(\.sources).first {
            $0.accessPoint.contains("/Sources/src.") && $0.accessPoint.contains("-")
        }
        #expect(uuidSource != nil)
        #expect(uuidSource?.originStorage?.isEmpty == true)
        #expect(uuidSource?.originStorageSource?.isEmpty == true)
    }

    @Test("nested camera in archive binding has UNSPECIFIED access")
    func nested_camera_access_from_full_sse() throws {
        let raw = try FixtureLoader.loadData(resource: "v1_domain_archives_2_10_0_full", ext: "sse")
        let pages = try decodeSse(ArchiveListPage.self, from: raw, using: decoder)
        let archive = try #require(pages.first?.items.first)
        let camera = try #require(archive.bindings.first?.camera)
        #expect(camera.cameraAccess.rawValue == "CAMERA_ACCESS_UNSPECIFIED")
        #expect(camera.archiveBindings?.isEmpty == true)
    }
}
