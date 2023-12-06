import SwiftAtproto
import Foundation
extension comatprototypes {
    class AdminEnableAccountInvites_Input: Codable {
        let type = "com.atproto.admin.enableAccountInvites"
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
    static func AdminEnableAccountInvites(input: AdminEnableAccountInvites_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.admin.enableAccountInvites", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}