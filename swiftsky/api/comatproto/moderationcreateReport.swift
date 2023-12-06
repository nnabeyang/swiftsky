import SwiftAtproto
import Foundation
extension comatprototypes {
    class ModerationCreateReport_Input: Codable {
        let type = "com.atproto.moderation.createReport"
        var reason: String?
        var reasonType: String
        var subject: ModerationCreateReport_Input_Subject
        init(reason: String?, reasonType: String, subject: ModerationCreateReport_Input_Subject) {
            self.reason = reason
            self.reasonType = reasonType
            self.subject = subject
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case reason
            case reasonType
            case subject
        }
    }
    enum ModerationCreateReport_Input_Subject: Codable {
        case adminDefsRepoRef(AdminDefs_RepoRef)
        case repoStrongRef(RepoStrongRef)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "com.atproto.admin.defs#repoRef":
                self = try .adminDefsRepoRef(.init(from: decoder))
            case "com.atproto.repo.strongRef":
                self = try .repoStrongRef(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .adminDefsRepoRef(value):
                try container.encode(value)
            case let .repoStrongRef(value):
                try container.encode(value)
            }
        }
    }
    class ModerationCreateReport_Output: Codable {
        let type = "com.atproto.moderation.createReport"
        var createdAt: String
        var id: Int
        var reason: String?
        var reasonType: String
        var reportedBy: String
        var subject: ModerationCreateReport_Output_Subject
        init(createdAt: String, id: Int, reason: String?, reasonType: String, reportedBy: String, subject: ModerationCreateReport_Output_Subject) {
            self.createdAt = createdAt
            self.id = id
            self.reason = reason
            self.reasonType = reasonType
            self.reportedBy = reportedBy
            self.subject = subject
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case createdAt
            case id
            case reason
            case reasonType
            case reportedBy
            case subject
        }
    }
    enum ModerationCreateReport_Output_Subject: Codable {
        case adminDefsRepoRef(AdminDefs_RepoRef)
        case repoStrongRef(RepoStrongRef)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "com.atproto.admin.defs#repoRef":
                self = try .adminDefsRepoRef(.init(from: decoder))
            case "com.atproto.repo.strongRef":
                self = try .repoStrongRef(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .adminDefsRepoRef(value):
                try container.encode(value)
            case let .repoStrongRef(value):
                try container.encode(value)
            }
        }
    }
    static func ModerationCreateReport(input: ModerationCreateReport_Input) async throws -> ModerationCreateReport_Output {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.moderation.createReport", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}