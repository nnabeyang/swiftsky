import SwiftAtproto
import Foundation
extension comatprototypes {
    static func AdminGetRecord(cid: String?, uri: String) async throws -> AdminDefs_RecordViewDetail {
        let params: Parameters = ["cid": .string(cid), "uri": .string(uri)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.admin.getRecord", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}