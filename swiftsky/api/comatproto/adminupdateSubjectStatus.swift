//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension comatprototypes {
    class AdminUpdateSubjectStatus_Input: Codable {
        var subject: AdminUpdateSubjectStatus_Input_Subject
        var takedown: AdminDefs_StatusAttr?

        init(subject: AdminUpdateSubjectStatus_Input_Subject, takedown: AdminDefs_StatusAttr?) {
            self.subject = subject
            self.takedown = takedown
        }

        enum CodingKeys: String, CodingKey {
            case subject
            case takedown
        }
    }

    enum AdminUpdateSubjectStatus_Input_Subject: Codable {
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
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case let .adminDefsRepoRef(value):
                try container.encode("com.atproto.admin.defs#repoRef", forKey: .type)
                try value.encode(to: encoder)
            case let .repoStrongRef(value):
                try container.encode("com.atproto.repo.strongRef", forKey: .type)
                try value.encode(to: encoder)
            case let .adminDefsRepoBlobRef(value):
                try container.encode("com.atproto.admin.defs#repoBlobRef", forKey: .type)
                try value.encode(to: encoder)
            }
        }
    }

    class AdminUpdateSubjectStatus_Output: Codable {
        var subject: AdminUpdateSubjectStatus_Output_Subject
        var takedown: AdminDefs_StatusAttr?

        init(subject: AdminUpdateSubjectStatus_Output_Subject, takedown: AdminDefs_StatusAttr?) {
            self.subject = subject
            self.takedown = takedown
        }

        enum CodingKeys: String, CodingKey {
            case subject
            case takedown
        }
    }

    enum AdminUpdateSubjectStatus_Output_Subject: Codable {
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
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case let .adminDefsRepoRef(value):
                try container.encode("com.atproto.admin.defs#repoRef", forKey: .type)
                try value.encode(to: encoder)
            case let .repoStrongRef(value):
                try container.encode("com.atproto.repo.strongRef", forKey: .type)
                try value.encode(to: encoder)
            case let .adminDefsRepoBlobRef(value):
                try container.encode("com.atproto.admin.defs#repoBlobRef", forKey: .type)
                try value.encode(to: encoder)
            }
        }
    }

    static func AdminUpdateSubjectStatus(client: any XRPCClientProtocol, input: AdminUpdateSubjectStatus_Input) async throws -> AdminUpdateSubjectStatus_Output {
        let params: Bool? = nil
        return try await client.fetch(endpoint: "com.atproto.admin.updateSubjectStatus", contentType: "application/json", httpMethod: .post, params: params, input: input, retry: true)
    }
}
