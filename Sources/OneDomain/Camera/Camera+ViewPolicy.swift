import Foundation
import OneSecurity

extension Camera {
    /// Security policy for opening this camera and viewing live/archive streams.
    ///
    /// Combines:
    /// - global role permissions (`user`, from `SecurityApi.globalUserPermissions`)
    /// - per-camera access (`cameraAccess` — server-computed effective access)
    /// - runtime state (`armed`, privacy masks, archive bindings)
    ///
    /// Group-level permissions are **not** merged client-side; trust `cameraAccess` from the server.
    ///
    /// - Parameter hasDynamicPrivacyMask: Pass `true` when the selected live stream advertises
    ///   a dynamic privacy mask (not persisted on `Camera`). Defaults to `false`.
    ///
    /// - Returns: Use `canOpen` before navigation; `canViewLive` / `canViewArchive` for stream tabs;
    ///   `watermark` / `masking` for video renderers.
    public func viewPolicy(
        for user: UserSecurityContext,
        hasDynamicPrivacyMask: Bool = false
    ) -> CameraViewPolicy {
        CameraPolicyEvaluator.evaluate(
            user: user,
            objectAccess: cameraAccess.value ?? .unspecified,
            isArmed: armed,
            hasStaticPrivacyMask: !(privacyMask?.isEmpty ?? true),
            hasDynamicPrivacyMask: hasDynamicPrivacyMask,
            hasArchives: hasArchiveBindings ?? !(archiveBindings?.isEmpty ?? true)
        )
    }
}
