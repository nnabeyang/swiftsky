import SwiftAtproto
import Foundation
extension comatprototypes {
    class ServerCreateInviteCodes_AccountCodes: Codable {
        let type = "com.atproto.server.createInviteCodes#accountCodes"
        var account: String
        var codes: [String]
        init(account: String, codes: [String]) {
            self.account = account
            self.codes = codes
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case account
            case codes
        }
    }
    class ServerCreateInviteCodes_Input: Codable {
        let type = "com.atproto.server.createInviteCodes"
        var codeCount: Int
        var forAccounts: [String]?
        var useCount: Int
        init(codeCount: Int, forAccounts: [String]?, useCount: Int) {
            self.codeCount = codeCount
            self.forAccounts = forAccounts
            self.useCount = useCount
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case codeCount
            case forAccounts
            case useCount
        }
    }
    class ServerCreateInviteCodes_Output: Codable {
        let type = "com.atproto.server.createInviteCodes"
        var codes: [ServerCreateInviteCodes_AccountCodes]
        init(codes: [ServerCreateInviteCodes_AccountCodes]) {
            self.codes = codes
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case codes
        }
    }
    static func ServerCreateInviteCodes(input: ServerCreateInviteCodes_Input) async throws -> ServerCreateInviteCodes_Output {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.createInviteCodes", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}