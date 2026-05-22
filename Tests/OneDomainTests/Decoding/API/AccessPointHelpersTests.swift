import Foundation
import Testing
@testable import OneDomain

@Suite("AccessPoint helpers")
struct AccessPointHelpersTests {
    private let endpoint: AccessPoint = "hosts/DemoServer/DeviceIpint.5/SourceEndpoint.video:0:0"
    private let source: AccessPoint =
        "hosts/DemoServer/MultimediaStorage.A/Sources/src.8F3D2A1B-4C5E-6F70-8192-A3B4C5D6E7F8"
    private let nohostsEndpoint: AccessPoint = "DemoServer/DeviceIpint.5/SourceEndpoint.video:0:0"

    @Test("empty string is identity for nohosts and hosts")
    func empty_string() {
        let ap: AccessPoint = ""
        #expect(ap.nohosts == "")
        #expect(ap.hosts == "")
        #expect(ap.deviceID == "")
    }

    @Test("nohosts strips hosts prefix from 4-segment endpoint")
    func nohosts_strips_prefix() {
        #expect(endpoint.nohosts == nohostsEndpoint)
    }

    @Test("hosts adds prefix to 3-segment path")
    func hosts_adds_prefix() {
        #expect(nohostsEndpoint.hosts == endpoint)
    }

    @Test("hosts is idempotent for 4-segment endpoint")
    func hosts_idempotent() {
        #expect(endpoint.hosts == endpoint)
    }

    @Test("hostsDevice drops endpoint segment")
    func hostsDevice_endpoint() {
        #expect(endpoint.hostsDevice == "hosts/DemoServer/DeviceIpint.5")
    }

    @Test("deviceID extracts device number from endpoint")
    func deviceID_endpoint() {
        #expect(endpoint.deviceID == "5")
    }

    @Test("five-segment storage source passes validation")
    func five_segment_source() {
        #expect(source.components(separatedBy: "/").count == 5)
        #expect(source.nohosts.contains("/Sources/"))
    }
}
