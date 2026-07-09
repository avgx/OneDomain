import Foundation

extension Camera {
    public var archiveBindingsForEnabledAndActivatedArchives: [ArchiveBinding]? {
        return archiveBindings?
            .filter({ $0.archive?.enabled ?? false })
            .filter({$0.archive?.isActivated ?? false})
    }
}

extension Camera {
    public var selectableArchiveBindings: [ArchiveBinding] {
        let bindings = archiveBindingsForEnabledAndActivatedArchives ?? []
        return ArchiveBinding.ordered(bindings)
    }
}
