import SwiftAtproto
import Foundation
extension comatprototypes {
    class SyncNotifyOfUpdate_Input: Codable {
        let type = "com.atproto.sync.notifyOfUpdate"
        var hostname: String
        init(hostname: String) {
            self.hostname = hostname
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case hostname
        }
    }
    static func SyncNotifyOfUpdate(input: SyncNotifyOfUpdate_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.sync.notifyOfUpdate", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}