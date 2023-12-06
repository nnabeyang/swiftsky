import SwiftAtproto
import Foundation
extension comatprototypes {
    static func SyncGetRecord(collection: String, commit: String?, did: String, rkey: String) async throws -> Data {
        let params: Parameters = ["collection": .string(collection), "commit": .string(commit), "did": .string(did), "rkey": .string(rkey)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.sync.getRecord", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}