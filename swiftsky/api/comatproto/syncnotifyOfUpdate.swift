//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension comatprototypes {
    class SyncNotifyOfUpdate_Input: Codable {
        var hostname: String

        init(hostname: String) {
            self.hostname = hostname
        }

        enum CodingKeys: String, CodingKey {
            case hostname
        }
    }

    static func SyncNotifyOfUpdate(client: any XRPCClientProtocol, input: SyncNotifyOfUpdate_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await client.fetch(endpoint: "com.atproto.sync.notifyOfUpdate", contentType: "application/json", httpMethod: .post, params: params, input: input, retry: true)
    }
}
