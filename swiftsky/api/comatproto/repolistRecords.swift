import SwiftAtproto
import Foundation
extension comatprototypes {
    class RepoListRecords_Output: Codable {
        let type = "com.atproto.repo.listRecords"
        var cursor: String?
        var records: [RepoListRecords_Record]
        init(cursor: String?, records: [RepoListRecords_Record]) {
            self.cursor = cursor
            self.records = records
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cursor
            case records
        }
    }
    class RepoListRecords_Record: Codable {
        let type = "com.atproto.repo.listRecords#record"
        var cid: String
        var uri: String
        var value: LexiconTypeDecoder
        init(cid: String, uri: String, value: LexiconTypeDecoder) {
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
    static func RepoListRecords(collection: String, cursor: String?, limit: Int?, repo: String, reverse: Bool?, rkeyEnd: String?, rkeyStart: String?) async throws -> RepoListRecords_Output {
        let params: Parameters = ["collection": .string(collection), "cursor": .string(cursor), "limit": .integer(limit), "repo": .string(repo), "reverse": .bool(reverse), "rkeyEnd": .string(rkeyEnd), "rkeyStart": .string(rkeyStart)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.repo.listRecords", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}