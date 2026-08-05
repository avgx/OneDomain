import Foundation
import Testing
@testable import OneDomain

@Suite("CameraPrivacyMask decoding")
struct CameraPrivacyMaskDecodingTests {
    @Test("decode minimal JSON")
    func decode_minimal() throws {
        let json = """
        {"id":"mask-1","value":{}}
        """
        let value = try JSONDecoder().decode(CameraPrivacyMask.self, from: Data(json.utf8))
        #expect(value.id == "mask-1")
        #expect(value.value != nil)
        #expect(value.value?.normalizedPoints.isEmpty == true)
    }

    @Test("decode mosaic polygon")
    func decode_mosaicPolygon() throws {
        let json = """
        {
          "id":"mask-2",
          "value":{
            "type":"Mosaic",
            "value":{
              "points":[
                {"x":0.1,"y":0.2},
                {"x":0.4,"y":0.2},
                {"x":0.4,"y":0.5},
                {"x":0.1,"y":0.5}
              ]
            }
          }
        }
        """
        let value = try JSONDecoder().decode(CameraPrivacyMask.self, from: Data(json.utf8))
        #expect(value.id == "mask-2")
        #expect(value.value?.type?.value == .mosaic)
        #expect(value.value?.normalizedPoints.count == 4)
        #expect(value.value?.prefersMosaic == true)
    }

    @Test("decode default mask type")
    func decode_defaultType() throws {
        let json = """
        {
          "id":"mask-3",
          "value":{
            "type":"Default",
            "value":{"points":[{"x":0,"y":0},{"x":1,"y":0},{"x":1,"y":1}]}
          }
        }
        """
        let value = try JSONDecoder().decode(CameraPrivacyMask.self, from: Data(json.utf8))
        #expect(value.value?.type?.value == .default)
        #expect(value.value?.prefersMosaic == false)
    }
}
