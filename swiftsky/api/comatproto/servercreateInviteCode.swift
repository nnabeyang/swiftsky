//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension comatprototypes {
    class ServerCreateInviteCode_Input: Codable {
        var forAccount: String?
        var useCount: Int

        init(forAccount: String?, useCount: Int) {
            self.forAccount = forAccount
            self.useCount = useCount
        }

        enum CodingKeys: String, CodingKey {
            case forAccount
            case useCount
        }
    }

    class ServerCreateInviteCode_Output: Codable {
        var code: String

        init(code: String) {
            self.code = code
        }

        enum CodingKeys: String, CodingKey {
            case code
        }
    }

    static func ServerCreateInviteCode(client: any XRPCClientProtocol, input: ServerCreateInviteCode_Input) async throws -> ServerCreateInviteCode_Output {
        let params: Bool? = nil
        return try await client.fetch(endpoint: "com.atproto.server.createInviteCode", contentType: "application/json", httpMethod: .post, params: params, input: input, retry: true)
    }
}
