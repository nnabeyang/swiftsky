import SwiftAtproto
import Foundation
extension comatprototypes {
    static func AdminGetRepo(did: String) async throws -> AdminDefs_RepoViewDetail {
        let params: Parameters = ["did": .string(did)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.admin.getRepo", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}