import SwiftAtproto
import Foundation
extension comatprototypes {
    class ServerGetAccountInviteCodes_Output: Codable {
        let type = "com.atproto.server.getAccountInviteCodes"
        var codes: [ServerDefs_InviteCode]
        init(codes: [ServerDefs_InviteCode]) {
            self.codes = codes
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case codes
        }
    }
    static func ServerGetAccountInviteCodes(createAvailable: Bool?, includeUsed: Bool?) async throws -> ServerGetAccountInviteCodes_Output {
        let params: Parameters = ["createAvailable": .bool(createAvailable), "includeUsed": .bool(includeUsed)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.getAccountInviteCodes", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}