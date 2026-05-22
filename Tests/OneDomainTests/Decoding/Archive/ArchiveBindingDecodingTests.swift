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

    @Test("decode archives view binding with camera and without archive")
    func decode_archives_view_binding() throws {
        let json = """
        {"name":"hosts/DemoServer/DeviceIpint.1/SourceEndpoint.video:0:0","storage":"hosts/DemoServer/MultimediaStorage.A/MultimediaStorage","camera":{"access_point":"hosts/DemoServer/DeviceIpint.1/SourceEndpoint.video:0:0","display_name":"Camera 1","display_id":"1","ip_address":"0.0.0.0","camera_access":"CAMERA_ACCESS_UNSPECIFIED","vendor":"Virtual","model":"Virtual","firmware":"1.0.0","enabled":true,"is_activated":true,"video_streams":[],"microphones":[],"ptzs":[],"archive_bindings":[],"ray":[],"relay":[],"detectors":[],"offline_detectors":[],"group_ids":[],"text_sources":[],"speakers":[]},"is_default":false,"is_replica":false,"is_permanent":true,"has_live_sources":true,"has_replica_sources":false,"sources":[{"access_point":"hosts/DemoServer/MultimediaStorage.A/Sources/src.8F3D2A1B-4C5E-6F70-8192-A3B4C5D6E7F8","storage":"hosts/DemoServer/MultimediaStorage.A/MultimediaStorage","binding":"hosts/DemoServer/DeviceIpint.1/SourceEndpoint.video:0:0","media_source":"hosts/DemoServer/DeviceIpint.1/SourceEndpoint.video:0:0","origin":"hosts/DemoServer/DeviceIpint.1/SourceEndpoint.video:0:0","mimetype":"video/vc-raw","origin_storage":"","origin_storage_source":"","prerecording":0}]}
        """
        let value = try JSONDecoder().decode(ArchiveBinding.self, from: Data(json.utf8))
        #expect(value.camera != nil)
        #expect(value.archive == nil)
        #expect(value.sources.first?.originStorage?.isEmpty == true)
    }
}
