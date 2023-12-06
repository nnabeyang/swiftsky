import SwiftAtproto
import Foundation
extension comatprototypes {
    class AdminDeleteAccount_Input: Codable {
        let type = "com.atproto.admin.deleteAccount"
        var did: String
        init(did: String) {
            self.did = did
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
        }
    }
    static func AdminDeleteAccount(input: AdminDeleteAccount_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.admin.deleteAccount", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}