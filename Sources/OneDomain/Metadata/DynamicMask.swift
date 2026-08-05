import Foundation

/// Raster privacy mask derived from WS MASK grid or privacy VMDA tracklets.
public struct DynamicMask: Sendable, Equatable {
    /// Media time for this mask (from VMDA ASIP or WS packet PTS).
    public let timestamp: Date?
    public let width: Int
    public let height: Int
    public var maskBytes: [UInt8]
    public let bytesPerItem: Int
    public let appearance: Appearance
    public let isPrivacyDetectorInfo: Bool

    public enum Appearance: Sendable, Equatable {
        case mosaic
        case black
    }

    public var isValid: Bool {
        width > 0 && height > 0 && maskBytes.count == width * height
    }

    public init(
        timestamp: Date?,
        width: Int,
        height: Int,
        maskBytes: [UInt8],
        bytesPerItem: Int = 1,
        appearance: Appearance = .mosaic,
        isPrivacyDetectorInfo: Bool
    ) {
        self.timestamp = timestamp
        self.width = width
        self.height = height
        self.maskBytes = maskBytes
        self.bytesPerItem = bytesPerItem
        self.appearance = appearance
        self.isPrivacyDetectorInfo = isPrivacyDetectorInfo
    }

    /// Build mask from server MASK packet using the packet's own width/height.
    ///
    /// - Parameter timestamp: Optional media time (MASK JSON has none; pass WS packet PTS).
    public static func from(
        mask: TypedPrivacyMaskInfo,
        timestamp: Date? = nil,
        appearance: Appearance = .mosaic
    ) -> DynamicMask? {
        guard mask.isValid, let bytes = mask.maskBytes else { return nil }
        let item = max(mask.bytesPerItem, 1)
        let plane: [UInt8]
        if item == 1 {
            plane = bytes
        } else {
            // Keep first byte of each cell as alpha/mask strength.
            plane = stride(from: 0, to: bytes.count, by: item).map { bytes[$0] }
        }
        guard plane.count == mask.width * mask.height else { return nil }
        return DynamicMask(
            timestamp: timestamp,
            width: mask.width,
            height: mask.height,
            maskBytes: plane,
            bytesPerItem: 1,
            appearance: appearance,
            isPrivacyDetectorInfo: mask.isPrivacyDetectorInfo
        )
    }

    /// Rasterize privacy tracklet rectangles into a mask matching `size` (frame aspect).
    public static func from(
        vmdaData: VmdaData,
        size: (width: Int, height: Int),
        appearance: Appearance = .mosaic
    ) -> DynamicMask {
        let width = max(size.width, 1)
        let height = max(size.height, 1)
        var maskBytes = [UInt8](repeating: 0, count: width * height)

        for tracklet in vmdaData.tracklets {
            guard let rect = tracklet.rectangle,
                  let x = rect.x, let y = rect.y,
                  let w = rect.w, let h = rect.h else { continue }

            let left = max(0, Int((x * Double(width)).rounded(.down)))
            let top = max(0, Int((y * Double(height)).rounded(.down)))
            let right = min(width, Int(((x + w) * Double(width)).rounded(.up)))
            let bottom = min(height, Int(((y + h) * Double(height)).rounded(.up)))

            guard left < right, top < bottom else { continue }
            for row in top..<bottom {
                let rowStart = row * width
                for col in left..<right {
                    maskBytes[rowStart + col] = 255
                }
            }
        }

        return DynamicMask(
            timestamp: vmdaData.timestampDate,
            width: width,
            height: height,
            maskBytes: maskBytes,
            bytesPerItem: 1,
            appearance: appearance,
            isPrivacyDetectorInfo: vmdaData.isPrivacyDetectorInfo
        )
    }
}
