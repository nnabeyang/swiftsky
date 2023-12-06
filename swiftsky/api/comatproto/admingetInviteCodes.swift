import SwiftAtproto
import Foundation
extension comatprototypes {
    class AdminGetInviteCodes_Output: Codable {
        let type = "com.atproto.admin.getInviteCodes"
        var codes: [ServerDefs_InviteCode]
        var cursor: String?
        init(codes: [ServerDefs_InviteCode], cursor: String?) {
            self.codes = codes
            self.cursor = cursor
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case codes
            case cursor
        }
    }
    static func AdminGetInviteCodes(cursor: String?, limit: Int?, sort: String?) async throws -> AdminGetInviteCodes_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit), "sort": .string(sort)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.admin.getInviteCodes", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}