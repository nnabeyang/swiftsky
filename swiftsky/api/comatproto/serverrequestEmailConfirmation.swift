import SwiftAtproto
import Foundation
extension comatprototypes {
    static func ServerRequestEmailConfirmation() async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.requestEmailConfirmation", contentType: "*/*", httpMethod: .post, params: params, input: Bool?.none)
    }
}