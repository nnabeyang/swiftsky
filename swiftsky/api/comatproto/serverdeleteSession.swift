import SwiftAtproto
import Foundation
extension comatprototypes {
    static func ServerDeleteSession() async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.deleteSession", contentType: "*/*", httpMethod: .post, params: params, input: Bool?.none)
    }
}