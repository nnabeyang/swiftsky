//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension comatprototypes {
    static func ServerDeleteSession(client: any XRPCClientProtocol) async throws -> Bool {
        let params: Bool? = nil
        return try await client.fetch(endpoint: "com.atproto.server.deleteSession", contentType: "*/*", httpMethod: .post, params: params, input: Bool?.none, retry: true)
    }
}
