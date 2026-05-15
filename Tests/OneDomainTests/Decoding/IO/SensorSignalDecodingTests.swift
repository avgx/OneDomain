import Foundation
import Testing
@testable import OneDomain

@Suite("SensorSignal decoding")
struct SensorSignalDecodingTests {
    @Test("decode minimal JSON")
    func decode_minimal() throws {
        let json = """
        {"name":"signal","precision":2,"measurement_unit":"V","level_limits":{"min":0,"max":10}}
        """
        let value = try JSONDecoder().decode(SensorSignal.self, from: Data(json.utf8))
        #expect(value.name == "signal")
    }
}
