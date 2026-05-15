import Foundation
import Testing
@testable import OneDomain

@Suite("ArchiveBinding decoding")
struct ArchiveBindingDecodingTests {
    @Test("decode minimal JSON")
    func decode_minimal() throws {
        let json = """
        {"name":"binding","storage":"storage","is_default":true,"is_replica":false,"is_permanent":true,"has_live_sources":true,"has_replica_sources":false,"sources":[{"access_point":"hosts/1/Sources.1","storage":"s","binding":"b","media_source":"m","origin":"o","mimetype":"video","origin_storage":"os","origin_storage_source":"oss","prerecording":0}],"archive":{"access_point":"hosts/1/Archives.1","incomplete":false,"display_name":"Archive","display_id":"1","is_embedded":false,"archive_access":"ARCHIVE_ACCESS_FULL","bindings":[],"is_activated":true,"enabled":true}}
        """
        let value = try JSONDecoder().decode(ArchiveBinding.self, from: Data(json.utf8))
        #expect(value.name == "binding")
    }
}
