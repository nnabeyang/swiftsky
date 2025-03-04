//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension comatprototypes {
    class ServerConfirmEmail_Input: Codable {
        var email: String
        var token: String

        init(email: String, token: String) {
            self.email = email
            self.token = token
        }

        enum CodingKeys: String, CodingKey {
            case email
            case token
        }
    }

    static func ServerConfirmEmail(client: any XRPCClientProtocol, input: ServerConfirmEmail_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await client.fetch(endpoint: "com.atproto.server.confirmEmail", contentType: "application/json", httpMethod: .post, params: params, input: input, retry: true)
    }
}
