//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension comatprototypes {
    class ServerUpdateEmail_Input: Codable {
        var email: String
        var token: String?

        init(email: String, token: String?) {
            self.email = email
            self.token = token
        }

        enum CodingKeys: String, CodingKey {
            case email
            case token
        }
    }

    static func ServerUpdateEmail(client: any XRPCClientProtocol, input: ServerUpdateEmail_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await client.fetch(endpoint: "com.atproto.server.updateEmail", contentType: "application/json", httpMethod: .post, params: params, input: input, retry: true)
    }
}
