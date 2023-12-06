import SwiftAtproto
import Foundation
extension comatprototypes {
    class RepoApplyWrites_Create: Codable {
        let type = "com.atproto.repo.applyWrites#create"
        var collection: String
        var rkey: String?
        var value: LexiconTypeDecoder
        init(collection: String, rkey: String?, value: LexiconTypeDecoder) {
            self.collection = collection
            self.rkey = rkey
            self.value = value
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case collection
            case rkey
            case value
        }
    }
    class RepoApplyWrites_Delete: Codable {
        let type = "com.atproto.repo.applyWrites#delete"
        var collection: String
        var rkey: String
        init(collection: String, rkey: String) {
            self.collection = collection
            self.rkey = rkey
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case collection
            case rkey
        }
    }
    class RepoApplyWrites_Input: Codable {
        let type = "com.atproto.repo.applyWrites"
        var repo: String
        var swapCommit: String?
        var validate: Bool?
        var writes: [RepoApplyWrites_Input_Writes_Elem]
        init(repo: String, swapCommit: String?, validate: Bool?, writes: [RepoApplyWrites_Input_Writes_Elem]) {
            self.repo = repo
            self.swapCommit = swapCommit
            self.validate = validate
            self.writes = writes
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case repo
            case swapCommit
            case validate
            case writes
        }
    }
    enum RepoApplyWrites_Input_Writes_Elem: Codable {
        case repoApplyWritesCreate(RepoApplyWrites_Create)
        case repoApplyWritesUpdate(RepoApplyWrites_Update)
        case repoApplyWritesDelete(RepoApplyWrites_Delete)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "com.atproto.repo.applyWrites#create":
                self = try .repoApplyWritesCreate(.init(from: decoder))
            case "com.atproto.repo.applyWrites#update":
                self = try .repoApplyWritesUpdate(.init(from: decoder))
            case "com.atproto.repo.applyWrites#delete":
                self = try .repoApplyWritesDelete(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .repoApplyWritesCreate(value):
                try container.encode(value)
            case let .repoApplyWritesUpdate(value):
                try container.encode(value)
            case let .repoApplyWritesDelete(value):
                try container.encode(value)
            }
        }
    }
    class RepoApplyWrites_Update: Codable {
        let type = "com.atproto.repo.applyWrites#update"
        var collection: String
        var rkey: String
        var value: LexiconTypeDecoder
        init(collection: String, rkey: String, value: LexiconTypeDecoder) {
            self.collection = collection
            self.rkey = rkey
            self.value = value
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case collection
            case rkey
            case value
        }
    }
    static func RepoApplyWrites(input: RepoApplyWrites_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.repo.applyWrites", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}