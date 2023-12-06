import SwiftAtproto
import Foundation
extension comatprototypes {
    static func AdminGetAccountInfo(did: String) async throws -> AdminDefs_AccountView {
        let params: Parameters = ["did": .string(did)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.admin.getAccountInfo", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}