//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension comatprototypes {
    class AdminGetSubjectStatus_Output: Codable {
        let type = "com.atproto.admin.getSubjectStatus"
        var subject: AdminGetSubjectStatus_Output_Subject
        var takedown: AdminDefs_StatusAttr?

        init(subject: AdminGetSubjectStatus_Output_Subject, takedown: AdminDefs_StatusAttr?) {
            self.subject = subject
            self.takedown = takedown
        }

        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case subject
            case takedown
        }
    }

    enum AdminGetSubjectStatus_Output_Subject: Codable {
        case adminDefsRepoRef(AdminDefs_RepoRef)
        case repoStrongRef(RepoStrongRef)
        case adminDefsRepoBlobRef(AdminDefs_RepoBlobRef)

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
            case "com.atproto.admin.defs#repoBlobRef":
                self = try .adminDefsRepoBlobRef(.init(from: decoder))
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
            case let .adminDefsRepoBlobRef(value):
                try container.encode(value)
            }
        }
    }

    static func AdminGetSubjectStatus(blob: String?, did: String?, uri: String?) async throws -> AdminGetSubjectStatus_Output {
        let params: Parameters = ["blob": .string(blob), "did": .string(did), "uri": .string(uri)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.admin.getSubjectStatus", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}
