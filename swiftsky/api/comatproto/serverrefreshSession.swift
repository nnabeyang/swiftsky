import SwiftAtproto
import Foundation
extension comatprototypes {
    class ServerRefreshSession_Output: Codable {
        let type = "com.atproto.server.refreshSession"
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
    static func ServerRefreshSession() async throws -> ServerRefreshSession_Output {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.refreshSession", contentType: "*/*", httpMethod: .post, params: params, input: Bool?.none)
    }
}