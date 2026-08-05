import Foundation

/// Dynamic privacy mask grid from WS type 3 (`TypedPrivacyMaskInfo` JSON).
public struct TypedPrivacyMaskInfo: Codable, Equatable, Sendable {
    public let additionalBytes: String
    public let bufferBase64: String
    public let bufferSizeStr: String
    public let bytesPerItemStr: String
    public let heightStr: String
    public let isPrivacyDetectorInfo: Bool
    public let maskTypeStr: String
    public let widthStr: String

    private enum CodingKeys: String, CodingKey {
        case additionalBytes = "additional_bytes"
        case bufferBase64 = "buffer_base64"
        case bufferSizeStr = "buffer_size"
        case bytesPerItemStr = "bytes_per_item"
        case heightStr = "height"
        case isPrivacyDetectorInfo = "is_privacy_detector_info"
        case maskTypeStr = "mask_type"
        case widthStr = "width"
    }

    public var maskType: Int { Int(maskTypeStr) ?? 0 }
    public var bufferSize: Int { Int(bufferSizeStr) ?? 0 }
    public var bytesPerItem: Int { Int(bytesPerItemStr) ?? 0 }
    public var width: Int { Int(widthStr) ?? 0 }
    public var height: Int { Int(heightStr) ?? 0 }

    public var decodedBuffer: Data? {
        Data(base64Encoded: bufferBase64)
    }

    public var maskBytes: [UInt8]? {
        guard let data = decodedBuffer else { return nil }
        return [UInt8](data)
    }

    public var isValid: Bool {
        guard let data = decodedBuffer else { return false }
        let expectedSize = width * height * max(bytesPerItem, 1)
        return data.count == expectedSize && (bufferSize == 0 || expectedSize == bufferSize)
    }

    public static func decode(from data: Data) -> TypedPrivacyMaskInfo? {
        try? JSONDecoder().decode(TypedPrivacyMaskInfo.self, from: data)
    }
}

/// Archive metadata container wrapping mask entries.
public struct TypedPrivacyMaskInfoContainer: Codable, Equatable, Sendable {
    public let mask: [TypedPrivacyMaskInfo]
}
