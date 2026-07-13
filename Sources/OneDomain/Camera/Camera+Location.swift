import Foundation

extension Camera {
    public var location: Location? {
        return Location(
                    latitude: geoLocationLatitude,
                    longitude: geoLocationLongitude,
                    azimuth: geoLocationAzimuth
                )
    }
}

public struct Location : Codable, Sendable, Equatable, CustomDebugStringConvertible {
    
    public let latitude: Double
    public let longitude: Double
    public let heading: Double?
    
    public init(latitude: Double, longitude: Double, heading: Double? = nil) {
        self.latitude = latitude
        self.longitude = longitude
        self.heading = heading
    }
    
    public var debugDescription: String {
        "[\(latitude), \(longitude)]"
    }
    
    public init?(latitude: String?, longitude: String?, azimuth: String?) {
        guard let latStr = latitude, let lonStr = longitude else {
            return nil
        }
        
        /// fix server locate ``, -> .``
        func parseDouble(_ str: String?) -> Double? {
            guard var s = str else { return nil }
            s = s.replacingOccurrences(of: ",", with: ".")
            return Double(s)
        }
        
        guard let latitudeVal = parseDouble(latStr), let longitudeVal = parseDouble(lonStr) else {
            return nil
        }
        
        if latitudeVal == 0 && longitudeVal == 0 {
            return nil
        }
        
        var headingVal: Double? = nil
        if let azStr = azimuth {
            headingVal = parseDouble(azStr)
        }
        
        self.init(latitude: latitudeVal, longitude: longitudeVal, heading: headingVal)
    }
}
