//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension comatprototypes {
    class ServerGetSession_Output: Codable {
        let type = "com.atproto.server.getSession"
        var did: String
        var didDoc: LexiconTypeDecoder?
        var email: String?
        var emailConfirmed: Bool?
        var handle: String

        init(did: String, didDoc: LexiconTypeDecoder?, email: String?, emailConfirmed: Bool?, handle: String) {
            self.did = did
            self.didDoc = didDoc
            self.email = email
            self.emailConfirmed = emailConfirmed
            self.handle = handle
        }

        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
            case didDoc
            case email
            case emailConfirmed
            case handle
        }
    }

    static func ServerGetSession(client: any XRPCClientProtocol) async throws -> ServerGetSession_Output {
        let params: Bool? = nil
        return try await client.fetch(endpoint: "com.atproto.server.getSession", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none, retry: true)
    }
}
