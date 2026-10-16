import Testing
@testable import OneDomain

@Suite("Location string init")
struct LocationInitTests {
    @Test("rejects latitude outside -90...90")
    func rejectsInvalidLatitude() {
        #expect(Location(latitude: "158", longitude: "0", azimuth: nil) == nil)
        #expect(Location(latitude: "-91", longitude: "10", azimuth: nil) == nil)
    }

    @Test("rejects longitude outside -180...180")
    func rejectsInvalidLongitude() {
        #expect(Location(latitude: "55", longitude: "181", azimuth: nil) == nil)
        #expect(Location(latitude: "55", longitude: "-181", azimuth: nil) == nil)
    }

    @Test("keeps the zero-zero sentinel and accepts pole and antimeridian")
    func acceptsValidEdges() {
        #expect(Location(latitude: "0", longitude: "0", azimuth: nil) == nil)
        let pole = Location(latitude: "90", longitude: "180", azimuth: nil)
        #expect(pole?.latitude == 90)
        #expect(pole?.longitude == 180)
        #expect(Location(latitude: "55,75", longitude: "37,61", azimuth: "12,5")?.heading == 12.5)
    }
}
