import Foundation
import Testing
@testable import OneDomain

@Suite("AudioPlayer decoding")
struct AudioPlayerDecodingTests {
    @Test("decode from minimal speaker tracks")
    func decode_from_fixture() throws {
        let json = """
        {"state_control_ap":"hosts/1/State.1","audio_source_ap":"hosts/1/Audio.1","file_path":"/tmp/sound.wav"}
        """
        let value = try JSONDecoder().decode(AudioPlayer.self, from: Data(json.utf8))
        #expect(value.stateControlAp != nil)
    }
}
