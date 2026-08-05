import Foundation

/// Object track from VMDA metadata (`is_privacy_detector_info` false → UI tracks).
public struct Tracklet: Codable, Equatable, Sendable, Identifiable {
    public let id: Int
    public let rectangle: Rectangle?
    public let logicalCenter: Point?
    public let state: State?
    public let type: TrackletType?
    public let color: Color?
    public let behavior: Behavior?
    public let temperature: Temperature?

    public struct Point: Codable, Equatable, Sendable {
        public let x: Double
        public let y: Double
    }

    public enum TrackletType: String, Codable, Equatable, Sendable {
        case unspecified = "OBJECT_TYPE_UNSPECIFIED"
        case human = "OBJECT_TYPE_HUMAN"
        case groupOfHumans = "OBJECT_TYPE_GROUP_OF_HUMANS"
        case vehicle = "OBJECT_TYPE_VEHICLE"
        case face = "OBJECT_TYPE_FACE"
        case animal = "OBJECT_TYPE_ANIMAL"
        case robotDog = "OBJECT_TYPE_ROBOT_DOG"
    }

    public enum State: String, Codable, Equatable, Sendable {
        case appeared = "OBJECT_STATE_APPEARED"
        case disappeared = "OBJECT_STATE_DISAPPEARED"
        case normal = "OBJECT_STATE_NORMAL"
    }

    public enum Behavior: String, Codable, Equatable, Sendable {
        case moving = "MOVING_OBJECT"
        case abandoned = "ABANDONED_OBJECT"
        case abandonedTaken = "ABANDONED_TAKEN_OBJECT"
        case abandonedGiven = "ABANDONED_GIVEN_OBJECT"
        case unspecified = "OBJECT_BEHAVIOR_UNSPECIFIED"
    }

    public struct Color: Codable, Equatable, Sendable {
        public let hue: Float
        public let saturation: Float
        public let value: Float
    }

    public struct Temperature: Codable, Equatable, Sendable {
        public let unit: TempUnit
        public let value: Float

        public enum TempUnit: String, Codable, Equatable, Sendable {
            case celsius = "CELSIUS"
            case fahrenheit = "FAHRENHEIT"
            case kelvin = "KELVIN"
            case unspecified = "UNSPECIFIED"
        }
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case rectangle
        case logicalCenter = "logical_center"
        case state
        case type
        case color
        case behavior
        case temperature
    }
}
