import SwiftAtproto
import Foundation
extension comatprototypes {
    static func SyncGetBlocks(cids: [String], did: String) async throws -> Data {
        let params: Parameters = ["cids": .array(cids), "did": .string(did)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.sync.getBlocks", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}