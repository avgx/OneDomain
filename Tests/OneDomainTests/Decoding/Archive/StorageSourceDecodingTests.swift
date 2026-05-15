import Foundation
import Testing
@testable import OneDomain

@Suite("StorageSource decoding")
struct StorageSourceDecodingTests {
    @Test("decode from minimal archive binding sources")
    func decode_from_fixture() throws {
        let json = """
        {"name":"binding","storage":"storage","is_default":true,"is_replica":false,"is_permanent":true,"has_live_sources":true,"has_replica_sources":false,"sources":[{"access_point":"hosts/1/Sources.1","storage":"s","binding":"b","media_source":"m","origin":"o","mimetype":"video","origin_storage":"os","origin_storage_source":"oss","prerecording":0}]}
        """
        let binding = try JSONDecoder().decode(ArchiveBinding.self, from: Data(json.utf8))
        let source = try #require(binding.sources.first)
        #expect(source.accessPoint.isEmpty == false)
    }
}
