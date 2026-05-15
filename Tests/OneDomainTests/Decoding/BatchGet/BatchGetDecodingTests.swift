import Foundation
import Testing
@testable import OneDomain

@Suite("BatchGet decoding")
struct BatchGetDecodingTests {
    @Test("decode BatchGetCamerasRequest")
    func decode_request() throws {
        let json = """
        {"items":[{"access_point":"hosts/1/Cameras.1","view":"FULL"}]}
        """
        let value = try JSONDecoder().decode(BatchGetCamerasRequest.self, from: Data(json.utf8))
        #expect(value.items.count == 1)
        #expect(value.items[0].view == .full)
    }

    @Test("decode BatchGetCamerasResponse")
    func decode_response() throws {
        let json = """
        {"items":[{"access_point":"ap","incomplete":false,"display_name":"n","display_id":"1","ip_address":"1.2.3.4","camera_access":"CAMERA_ACCESS_FULL","vendor":"v","model":"m","firmware":"f","enabled":true,"is_activated":true}]}
        """
        let value = try JSONDecoder().decode(BatchGetCamerasResponse.self, from: Data(json.utf8))
        #expect(value.items?.count == 1)
    }

    @Test("decode ResourceLocator")
    func decode_locator() throws {
        let json = """
        {"access_point":"hosts/1/Cameras.1","view":"BASIC"}
        """
        let value = try JSONDecoder().decode(ResourceLocator.self, from: Data(json.utf8))
        #expect(value.accessPoint == "hosts/1/Cameras.1")
        #expect(value.view == .basic)
    }
}
