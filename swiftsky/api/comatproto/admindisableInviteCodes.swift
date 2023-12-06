import SwiftAtproto
import Foundation
extension comatprototypes {
    class AdminDisableInviteCodes_Input: Codable {
        let type = "com.atproto.admin.disableInviteCodes"
        var accounts: [String]?
        var codes: [String]?
        init(accounts: [String]?, codes: [String]?) {
            self.accounts = accounts
            self.codes = codes
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case accounts
            case codes
        }
    }
    static func AdminDisableInviteCodes(input: AdminDisableInviteCodes_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.admin.disableInviteCodes", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}