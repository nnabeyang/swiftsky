import SwiftAtproto
import Foundation
extension comatprototypes {
    class ServerCreateSession_Input: Codable {
        let type = "com.atproto.server.createSession"
        var identifier: String
        var password: String
        init(identifier: String, password: String) {
            self.identifier = identifier
            self.password = password
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case identifier
            case password
        }
    }
    class ServerCreateSession_Output: Codable {
        let type = "com.atproto.server.createSession"
        var accessJwt: String
        var did: String
        var didDoc: LexiconTypeDecoder?
        var email: String?
        var emailConfirmed: Bool?
        var handle: String
        var refreshJwt: String
        init(accessJwt: String, did: String, didDoc: LexiconTypeDecoder?, email: String?, emailConfirmed: Bool?, handle: String, refreshJwt: String) {
            self.accessJwt = accessJwt
            self.did = did
            self.didDoc = didDoc
            self.email = email
            self.emailConfirmed = emailConfirmed
            self.handle = handle
            self.refreshJwt = refreshJwt
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case accessJwt
            case did
            case didDoc
            case email
            case emailConfirmed
            case handle
            case refreshJwt
        }
    }
    static func ServerCreateSession(input: ServerCreateSession_Input) async throws -> ServerCreateSession_Output {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.createSession", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}