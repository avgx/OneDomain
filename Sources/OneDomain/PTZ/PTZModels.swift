import Foundation

/// PTZ helper types (`axxonsoft.bl.ptz`) used by domain camera models.
///
/// Source: `TelemetryHelper.proto`.
public struct PtzCapabilities: Codable, Equatable, Sendable {
    public let isRelative: Bool?
    public let isContinuous: Bool?
    public let isAbsolute: Bool?
    public let isAuto: Bool?

    public init(
        isRelative: Bool?,
        isContinuous: Bool?,
        isAbsolute: Bool?,
        isAuto: Bool?
    ) {
        self.isRelative = isRelative
        self.isContinuous = isContinuous
        self.isAbsolute = isAbsolute
        self.isAuto = isAuto
    }

    private enum CodingKeys: String, CodingKey {
        case isRelative = "is_relative"
        case isContinuous = "is_continuous"
        case isAbsolute = "is_absolute"
        case isAuto = "is_auto"
    }
}

public struct PtzRange: Codable, Equatable, Sendable {
    public let min: Int?
    public let max: Int?

    public init(min: Int?, max: Int?) {
        self.min = min
        self.max = max
    }

    private enum CodingKeys: String, CodingKey {
        case min
        case max
    }
}

public struct PtzLimits: Codable, Equatable, Sendable {
    public let relativeStep: PtzRange?
    public let continuousSpeed: PtzRange?
    public let absolutePosition: PtzRange?

    public init(
        relativeStep: PtzRange?,
        continuousSpeed: PtzRange?,
        absolutePosition: PtzRange?
    ) {
        self.relativeStep = relativeStep
        self.continuousSpeed = continuousSpeed
        self.absolutePosition = absolutePosition
    }

    private enum CodingKeys: String, CodingKey {
        case relativeStep = "relative_step"
        case continuousSpeed = "continuous_speed"
        case absolutePosition = "absolute_position"
    }
}

