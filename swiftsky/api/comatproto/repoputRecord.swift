import SwiftAtproto
import Foundation
extension comatprototypes {
    class RepoPutRecord_Input: Codable {
        let type = "com.atproto.repo.putRecord"
        var collection: String
        var record: LexiconTypeDecoder
        var repo: String
        var rkey: String
        var swapCommit: String?
        var swapRecord: String?
        var validate: Bool?
        init(collection: String, record: LexiconTypeDecoder, repo: String, rkey: String, swapCommit: String?, swapRecord: String?, validate: Bool?) {
            self.collection = collection
            self.record = record
            self.repo = repo
            self.rkey = rkey
            self.swapCommit = swapCommit
            self.swapRecord = swapRecord
            self.validate = validate
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case collection
            case record
            case repo
            case rkey
            case swapCommit
            case swapRecord
            case validate
        }
    }
    class RepoPutRecord_Output: Codable {
        let type = "com.atproto.repo.putRecord"
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
    static func RepoPutRecord(input: RepoPutRecord_Input) async throws -> RepoPutRecord_Output {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.repo.putRecord", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}