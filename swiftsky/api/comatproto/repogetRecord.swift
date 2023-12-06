import SwiftAtproto
import Foundation
extension comatprototypes {
    class RepoGetRecord_Output: Codable {
        let type = "com.atproto.repo.getRecord"
        var cid: String?
        var uri: String
        var value: LexiconTypeDecoder
        init(cid: String?, uri: String, value: LexiconTypeDecoder) {
            self.cid = cid
            self.uri = uri
            self.value = value
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cid
            case uri
            case value
        }
    }
    static func RepoGetRecord(cid: String?, collection: String, repo: String, rkey: String) async throws -> RepoGetRecord_Output {
        let params: Parameters = ["cid": .string(cid), "collection": .string(collection), "repo": .string(repo), "rkey": .string(rkey)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.repo.getRecord", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}