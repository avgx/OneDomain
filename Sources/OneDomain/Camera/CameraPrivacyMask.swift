import Foundation
import SafeEnum

/// Camera privacy mask (`domain.CameraPrivacyMask`).
public struct CameraPrivacyMask: Codable, Equatable, Sendable {
    public let id: String
    public let value: PrivacyMask?

    /// Privacy mask geometry (`primitive.PrivacyMask`).
    public struct PrivacyMask: Codable, Equatable, Sendable {
        public let type: SafeEnum<MaskType>?
        public let value: SimplePolygon?

        public enum MaskType: String, Codable, Equatable, Sendable {
            case `default` = "Default"
            case mosaic = "Mosaic"
        }

        private enum CodingKeys: String, CodingKey {
            case type
            case value
        }
    }

    /// Normalized polygon (`primitive.SimplePolygon`).
    public struct SimplePolygon: Codable, Equatable, Sendable {
        public let points: [Point]

        private enum CodingKeys: String, CodingKey {
            case points
        }
    }

    /// Normalized point (`primitive.Point`), coordinates in 0…1.
    public struct Point: Codable, Equatable, Sendable {
        public let x: Double
        public let y: Double

        private enum CodingKeys: String, CodingKey {
            case x
            case y
        }
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case value
    }
}

extension CameraPrivacyMask.PrivacyMask {
    /// Prefer mosaic when any mask advertises mosaic type.
    public var prefersMosaic: Bool {
        type?.value == .mosaic
    }

    public var normalizedPoints: [CameraPrivacyMask.Point] {
        value?.points ?? []
    }
}
