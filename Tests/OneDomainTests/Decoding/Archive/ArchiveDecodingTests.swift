import Foundation
import Testing
@testable import OneDomain

@Suite("Archive decoding")
struct ArchiveDecodingTests {
    @Test("decode from minimal archive binding")
    func decode_from_fixture() throws {
        let json = """
        {"name":"binding","storage":"storage","is_default":true,"is_replica":false,"is_permanent":true,"has_live_sources":true,"has_replica_sources":false,"sources":[],"archive":{"access_point":"hosts/1/Archives.1","incomplete":false,"display_name":"Archive","display_id":"1","is_embedded":false,"archive_access":"ARCHIVE_ACCESS_FULL","bindings":[],"is_activated":true,"enabled":true}}
        """
        let binding = try JSONDecoder().decode(ArchiveBinding.self, from: Data(json.utf8))
        let archive = try #require(binding.archive)
        #expect(archive.accessPoint.isEmpty == false)
    }
}
