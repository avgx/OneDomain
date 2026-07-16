import Foundation
import RequestResponse
import Testing
@testable import OneDomain

@Suite("DomainApi.cameras request")
struct DomainApiCamerasTests {
    @Test("no parameters → query is nil")
    func cameras_noParameters() {
        let request = DomainApi.cameras()
        #expect(request.path == "v1/domain/cameras")
        #expect(request.method == .get)
        #expect(request.query == nil)
    }

    @Test("view only")
    func cameras_viewOnly() {
        let request = DomainApi.cameras(view: .VIEW_MODE_FULL)
        let query = request.query ?? []
        #expect(query.count == 1)
        #expect(query[0].0 == "view")
        #expect(query[0].1 == "VIEW_MODE_FULL")
    }

    @Test("pageSize and pageToken with view")
    func cameras_paginationParams() {
        let token = "NodeA|hosts/NodeA/DeviceIpint.2/SourceEndpoint.video:0:0"
        let request = DomainApi.cameras(
            view: .VIEW_MODE_FULL,
            pageSize: 2,
            pageToken: token
        )
        let query = request.query ?? []
        #expect(query.count == 3)
        #expect(query.contains { $0.0 == "view" && $0.1 == "VIEW_MODE_FULL" })
        #expect(query.contains { $0.0 == "page_size" && $0.1 == "2" })
        #expect(query.contains { $0.0 == "page_token" && $0.1 == token })
    }

    @Test("pageSize and pageToken without view")
    func cameras_paginationWithoutView() {
        let request = DomainApi.cameras(pageSize: 10, pageToken: "abc")
        let query = request.query ?? []
        #expect(query.count == 2)
        #expect(query.contains { $0.0 == "page_size" && $0.1 == "10" })
        #expect(query.contains { $0.0 == "page_token" && $0.1 == "abc" })
    }
}
