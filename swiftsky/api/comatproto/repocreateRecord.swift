import SwiftAtproto
import Foundation
extension comatprototypes {
    class RepoCreateRecord_Input: Codable {
        let type = "com.atproto.repo.createRecord"
        var collection: String
        var record: LexiconTypeDecoder
        var repo: String
        var rkey: String?
        var swapCommit: String?
        var validate: Bool?
        init(collection: String, record: LexiconTypeDecoder, repo: String, rkey: String?, swapCommit: String?, validate: Bool?) {
            self.collection = collection
            self.record = record
            self.repo = repo
            self.rkey = rkey
            self.swapCommit = swapCommit
            self.validate = validate
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case collection
            case record
            case repo
            case rkey
            case swapCommit
            case validate
        }
    }
    class RepoCreateRecord_Output: Codable {
        let type = "com.atproto.repo.createRecord"
        var cid: String
        var uri: String
        init(cid: String, uri: String) {
            self.cid = cid
            self.uri = uri
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cid
            case uri
        }
    }
    static func RepoCreateRecord(input: RepoCreateRecord_Input) async throws -> RepoCreateRecord_Output {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.repo.createRecord", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}