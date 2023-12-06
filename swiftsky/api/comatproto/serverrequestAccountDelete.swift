import SwiftAtproto
import Foundation
extension comatprototypes {
    static func ServerRequestAccountDelete() async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.requestAccountDelete", contentType: "*/*", httpMethod: .post, params: params, input: Bool?.none)
    }
}