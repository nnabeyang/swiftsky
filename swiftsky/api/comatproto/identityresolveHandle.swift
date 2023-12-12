//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension comatprototypes {
    class IdentityResolveHandle_Output: Codable {
        var did: String

        init(did: String) {
            self.did = did
        }

        enum CodingKeys: String, CodingKey {
            case did
        }
    }

    static func IdentityResolveHandle(client: any XRPCClientProtocol, handle: String) async throws -> IdentityResolveHandle_Output {
        let params: Parameters = ["handle": .string(handle)]
        return try await client.fetch(endpoint: "com.atproto.identity.resolveHandle", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none, retry: true)
    }
}
