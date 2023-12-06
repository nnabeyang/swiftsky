import SwiftAtproto
import Foundation
extension comatprototypes {
    static func SyncGetCheckout(did: String) async throws -> Data {
        let params: Parameters = ["did": .string(did)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.sync.getCheckout", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}