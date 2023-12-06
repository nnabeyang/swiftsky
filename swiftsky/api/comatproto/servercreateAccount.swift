import SwiftAtproto
import Foundation
extension comatprototypes {
    class ServerCreateAccount_Input: Codable {
        let type = "com.atproto.server.createAccount"
        var did: String?
        var email: String?
        var handle: String
        var inviteCode: String?
        var password: String?
        var plcOp: LexiconTypeDecoder?
        var recoveryKey: String?
        init(did: String?, email: String?, handle: String, inviteCode: String?, password: String?, plcOp: LexiconTypeDecoder?, recoveryKey: String?) {
            self.did = did
            self.email = email
            self.handle = handle
            self.inviteCode = inviteCode
            self.password = password
            self.plcOp = plcOp
            self.recoveryKey = recoveryKey
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
            case email
            case handle
            case inviteCode
            case password
            case plcOp
            case recoveryKey
        }
    }
    class ServerCreateAccount_Output: Codable {
        let type = "com.atproto.server.createAccount"
        var accessJwt: String
        var did: String
        var didDoc: LexiconTypeDecoder?
        var handle: String
        var refreshJwt: String
        init(accessJwt: String, did: String, didDoc: LexiconTypeDecoder?, handle: String, refreshJwt: String) {
            self.accessJwt = accessJwt
            self.did = did
            self.didDoc = didDoc
            self.handle = handle
            self.refreshJwt = refreshJwt
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case accessJwt
            case did
            case didDoc
            case handle
            case refreshJwt
        }
    }
    static func ServerCreateAccount(input: ServerCreateAccount_Input) async throws -> ServerCreateAccount_Output {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.createAccount", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}