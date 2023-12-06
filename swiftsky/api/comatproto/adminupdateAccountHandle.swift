import SwiftAtproto
import Foundation
extension comatprototypes {
    class AdminUpdateAccountHandle_Input: Codable {
        let type = "com.atproto.admin.updateAccountHandle"
        var did: String
        var handle: String
        init(did: String, handle: String) {
            self.did = did
            self.handle = handle
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
            case handle
        }
    }
    static func AdminUpdateAccountHandle(input: AdminUpdateAccountHandle_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.admin.updateAccountHandle", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}