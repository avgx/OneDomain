import Foundation
import OneWireFormat

/// Resolved archive playback endpoints from an ``ArchiveBinding``.
public struct ArchivePlaybackTarget: Sendable, Equatable {
    public let stream: AccessPoint
    public let archiveStorage: String?

    public init(stream: AccessPoint, archiveStorage: String?) {
        self.stream = stream
        self.archiveStorage = archiveStorage
    }
}

extension ArchiveBinding {
    public func playbackTarget(fallbackCamera: AccessPoint) -> ArchivePlaybackTarget {
        ArchivePlaybackTarget(
            stream: resolvedPlaybackStream(fallbackCamera: fallbackCamera),
            archiveStorage: storage.nilIfEmpty
        )
    }

    public static func ordered(_ bindings: [Self]) -> [Self] {
        bindings.sorted { rank($0) < rank($1) }
    }

    public static func firstPlaybackTarget(
        in bindings: [Self],
        fallbackCamera: AccessPoint
    ) -> ArchivePlaybackTarget? {
        guard let binding = ordered(bindings).first else { return nil }
        return binding.playbackTarget(fallbackCamera: fallbackCamera)
    }

    public static func playbackTarget(
        archiveStorage: AccessPoint,
        in bindings: [Self],
        fallbackCamera: AccessPoint
    ) -> ArchivePlaybackTarget? {
        if let binding = bindings.first(where: { $0.storage == archiveStorage }) {
            return binding.playbackTarget(fallbackCamera: fallbackCamera)
        }
        return firstPlaybackTarget(in: bindings, fallbackCamera: fallbackCamera)
    }

    private func resolvedPlaybackStream(fallbackCamera: AccessPoint) -> AccessPoint {
        let videoSources = sources.filter(isVideoArchiveSource(_:))

        if let mediaSource = videoSources.first?.mediaSource, !mediaSource.isEmpty {
            return mediaSource
        }

        if let cameraAP = camera?.accessPoint, !cameraAP.isEmpty {
            return cameraAP
        }
        return fallbackCamera
    }

    private static func rank(_ binding: ArchiveBinding) -> Int {
        if binding.isDefault { return 0 }
        if !(binding.archive?.isEmbedded ?? false) { return 1 }
        return 2
    }

    private func isVideoArchiveSource(_ source: StorageSource) -> Bool {
        guard !source.mediaSource.isEmpty else { return false }
        return source.mimetype.lowercased().contains("video")
            || source.mediaSource.lowercased().contains("sourceendpoint.video")
    }
}

private extension AccessPoint {
    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }
}
