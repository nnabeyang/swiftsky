import SwiftAtproto
import Foundation
extension comatprototypes {
    static func SyncGetBlob(cid: String, did: String) async throws -> Data {
        let params: Parameters = ["cid": .string(cid), "did": .string(did)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.sync.getBlob", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}