import SwiftAtproto
import Foundation
extension comatprototypes {
    class AdminDisableAccountInvites_Input: Codable {
        let type = "com.atproto.admin.disableAccountInvites"
        var account: String
        var note: String?
        init(account: String, note: String?) {
            self.account = account
            self.note = note
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case account
            case note
        }
    }
    static func AdminDisableAccountInvites(input: AdminDisableAccountInvites_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.admin.disableAccountInvites", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}