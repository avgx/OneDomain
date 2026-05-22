import Foundation

/// API types extracted from Native BL proto files.
///
/// Note: `AccessPoint` is intentionally spelled to match `access_point` usage in JSON.
/// `DEMOSERVER/DeviceIpint.5/SourceEndpoint.video:0:0`
/// `hosts/DEMOSERVER/DeviceIpint.5/SourceEndpoint.video:0:0`
/// `hosts/DEMOSERVER/MultimediaStorage.A/Sources/src.8F3D2A1B-4C5E-6F70-8192-A3B4C5D6E7F8`
public typealias AccessPoint = String

private let hostsPrefix = "hosts/"

extension AccessPoint {
    public static let invalidAccessPoint = "invalid/invalid/invalid"
    
    /// Result is 3 component:
    /// `DEMOSERVER/DeviceIpint.5/SourceEndpoint.video:0:0`
    public var nohosts: String {
        guard !self.isEmpty else { return self }
        precondition([3, 4, 5].contains(self.components(separatedBy: "/").count), "AccessPoint format validation")
        return self.starts(with: hostsPrefix) ? String(self.dropFirst(hostsPrefix.count)) : self
    }
    
    /// Result is 4 component:
    /// `hosts/DEMOSERVER/DeviceIpint.5/SourceEndpoint.video:0:0`
    public var hosts: String {
        guard !self.isEmpty else { return self }
        precondition([3, 4, 5].contains(self.components(separatedBy: "/").count), "AccessPoint format validation")
        return self.starts(with: hostsPrefix) ? self : "\(hostsPrefix)\(self)"
    }
    
    /// Result is: `hosts/DEMOSERVER/DeviceIpint.5`
    public var hostsDevice: String {
        return self.hosts.components(separatedBy: "/").dropLast().joined(separator: "/")
    }
    
    /// Result is: `5`
    public var deviceID: String {
        guard !self.isEmpty else { return self }
        return self.nohosts.components(separatedBy: "/")[1].components(separatedBy: ".")[1]
    }
}
