import SwiftAtproto
import Foundation
extension comatprototypes {
    static func SyncGetRepo(did: String, since: String?) async throws -> Data {
        let params: Parameters = ["did": .string(did), "since": .string(since)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.sync.getRepo", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}