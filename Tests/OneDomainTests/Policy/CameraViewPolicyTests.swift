import Foundation
import Testing
import OneSecurity
@testable import OneDomain

@Suite("Camera view policy")
struct CameraViewPolicyTests {
    @Test("viewPolicy merges camera access and user context")
    func viewPolicy() throws {
        let camera = try FixtureLoader.firstCamera(resource: "v1_domain_cameras_1_0_4", ext: "json")
        let user = UserSecurityContext(
            isUnrestricted: false,
            prohibitAny: false,
            forceWatermark: false,
            defaultCameraAccess: .forbid,
            featureAccess: [],
            alertAccess: .forbid
        )

        let policy = camera.viewPolicy(for: user)

        #expect(policy.canOpen)
        #expect(policy.canViewLive)
        #expect(!policy.canViewArchive) // fixture has no archive bindings
        #expect(policy.denialReason == .noArchives)
    }

    @Test("monitoring on protection respects armed state")
    func armedGating() {
        let json = """
        {"access_point":"hosts/1/DeviceIpint.1","display_name":"Cam","display_id":"1","ip_address":"1.2.3.4","camera_access":"CAMERA_ACCESS_MONITORING_ON_PROTECTION","vendor":"v","model":"m","firmware":"f","enabled":true,"is_activated":true,"armed":false}
        """
        let camera = try! JSONDecoder().decode(Camera.self, from: Data(json.utf8))
        let user = UserSecurityContext(
            isUnrestricted: false,
            prohibitAny: false,
            forceWatermark: false,
            defaultCameraAccess: .full,
            featureAccess: [],
            alertAccess: .forbid
        )

        let policy = camera.viewPolicy(for: user)

        #expect(policy.canOpen)
        #expect(!policy.canViewLive)
        #expect(policy.denialReason == .notArmed)
    }
}
