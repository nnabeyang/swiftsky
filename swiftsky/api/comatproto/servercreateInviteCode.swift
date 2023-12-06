import SwiftAtproto
import Foundation
extension comatprototypes {
    class ServerCreateInviteCode_Input: Codable {
        let type = "com.atproto.server.createInviteCode"
        var forAccount: String?
        var useCount: Int
        init(forAccount: String?, useCount: Int) {
            self.forAccount = forAccount
            self.useCount = useCount
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case forAccount
            case useCount
        }
    }
    class ServerCreateInviteCode_Output: Codable {
        let type = "com.atproto.server.createInviteCode"
        var code: String
        init(code: String) {
            self.code = code
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case code
        }
    }
    static func ServerCreateInviteCode(input: ServerCreateInviteCode_Input) async throws -> ServerCreateInviteCode_Output {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.createInviteCode", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}