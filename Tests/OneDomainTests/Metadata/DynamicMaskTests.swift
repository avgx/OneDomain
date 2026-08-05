import Foundation
import Testing
@testable import OneDomain

@Suite("VmdaData / DynamicMask")
struct DynamicMaskTests {
    @Test("decode privacy vmda and rasterize to frame size")
    func vmdaRasterize() throws {
        let json = """
        {
          "is_privacy_detector_info": true,
          "timestamp": "20260320T142352.122000",
          "tracklets": [{
            "id": 1,
            "rectangle": {"x": 0.1, "y": 0.2, "w": 0.3, "h": 0.4},
            "state": "OBJECT_STATE_NORMAL",
            "type": "OBJECT_TYPE_HUMAN"
          }]
        }
        """
        let vmda = try #require(VmdaData.decode(from: Data(json.utf8)))
        #expect(vmda.isPrivacyDetectorInfo)
        #expect(vmda.tracklets.count == 1)
        #expect(vmda.timestampDate != nil)

        let mask = DynamicMask.from(vmdaData: vmda, size: (width: 32, height: 18))
        #expect(mask.width == 32)
        #expect(mask.height == 18)
        #expect(mask.maskBytes.contains(where: { $0 == 255 }))
        #expect(mask.isValid)
        #expect(mask.timestamp == vmda.timestampDate)
    }

    @Test("typed privacy mask uses server dimensions")
    func typedMaskDimensions() throws {
        var bytes = [UInt8](repeating: 0, count: 8)
        bytes[0] = 255
        bytes[7] = 255
        let base64 = Data(bytes).base64EncodedString()
        let json = """
        {
          "additional_bytes": "0",
          "buffer_base64": "\(base64)",
          "buffer_size": "8",
          "bytes_per_item": "1",
          "height": "2",
          "is_privacy_detector_info": true,
          "mask_type": "2",
          "width": "4"
        }
        """
        let info = try #require(TypedPrivacyMaskInfo.decode(from: Data(json.utf8)))
        let mask = try #require(DynamicMask.from(mask: info))
        #expect(mask.width == 4)
        #expect(mask.height == 2)
        #expect(mask.maskBytes[0] == 255)
        #expect(mask.timestamp == nil)
    }
}
