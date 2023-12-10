//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension comatprototypes {
    class RepoDeleteRecord_Input: Codable {
        let type = "com.atproto.repo.deleteRecord"
        var collection: String
        var repo: String
        var rkey: String
        var swapCommit: String?
        var swapRecord: String?

        init(collection: String, repo: String, rkey: String, swapCommit: String?, swapRecord: String?) {
            self.collection = collection
            self.repo = repo
            self.rkey = rkey
            self.swapCommit = swapCommit
            self.swapRecord = swapRecord
        }

        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case collection
            case repo
            case rkey
            case swapCommit
            case swapRecord
        }
    }

    static func RepoDeleteRecord(input: RepoDeleteRecord_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.repo.deleteRecord", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}
