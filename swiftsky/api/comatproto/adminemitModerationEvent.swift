import SwiftAtproto
import Foundation
extension comatprototypes {
    class AdminEmitModerationEvent_Input: Codable {
        let type = "com.atproto.admin.emitModerationEvent"
        var createdBy: String
        var event: AdminEmitModerationEvent_Input_Event
        var subject: AdminEmitModerationEvent_Input_Subject
        var subjectBlobCids: [String]?
        init(createdBy: String, event: AdminEmitModerationEvent_Input_Event, subject: AdminEmitModerationEvent_Input_Subject, subjectBlobCids: [String]?) {
            self.createdBy = createdBy
            self.event = event
            self.subject = subject
            self.subjectBlobCids = subjectBlobCids
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case createdBy
            case event
            case subject
            case subjectBlobCids
        }
    }
    enum AdminEmitModerationEvent_Input_Event: Codable {
        case adminDefsModEventTakedown(AdminDefs_ModEventTakedown)
        case adminDefsModEventAcknowledge(AdminDefs_ModEventAcknowledge)
        case adminDefsModEventEscalate(AdminDefs_ModEventEscalate)
        case adminDefsModEventComment(AdminDefs_ModEventComment)
        case adminDefsModEventLabel(AdminDefs_ModEventLabel)
        case adminDefsModEventReport(AdminDefs_ModEventReport)
        case adminDefsModEventMute(AdminDefs_ModEventMute)
        case adminDefsModEventReverseTakedown(AdminDefs_ModEventReverseTakedown)
        case adminDefsModEventUnmute(AdminDefs_ModEventUnmute)
        case adminDefsModEventEmail(AdminDefs_ModEventEmail)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "com.atproto.admin.defs#modEventTakedown":
                self = try .adminDefsModEventTakedown(.init(from: decoder))
            case "com.atproto.admin.defs#modEventAcknowledge":
                self = try .adminDefsModEventAcknowledge(.init(from: decoder))
            case "com.atproto.admin.defs#modEventEscalate":
                self = try .adminDefsModEventEscalate(.init(from: decoder))
            case "com.atproto.admin.defs#modEventComment":
                self = try .adminDefsModEventComment(.init(from: decoder))
            case "com.atproto.admin.defs#modEventLabel":
                self = try .adminDefsModEventLabel(.init(from: decoder))
            case "com.atproto.admin.defs#modEventReport":
                self = try .adminDefsModEventReport(.init(from: decoder))
            case "com.atproto.admin.defs#modEventMute":
                self = try .adminDefsModEventMute(.init(from: decoder))
            case "com.atproto.admin.defs#modEventReverseTakedown":
                self = try .adminDefsModEventReverseTakedown(.init(from: decoder))
            case "com.atproto.admin.defs#modEventUnmute":
                self = try .adminDefsModEventUnmute(.init(from: decoder))
            case "com.atproto.admin.defs#modEventEmail":
                self = try .adminDefsModEventEmail(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .adminDefsModEventTakedown(value):
                try container.encode(value)
            case let .adminDefsModEventAcknowledge(value):
                try container.encode(value)
            case let .adminDefsModEventEscalate(value):
                try container.encode(value)
            case let .adminDefsModEventComment(value):
                try container.encode(value)
            case let .adminDefsModEventLabel(value):
                try container.encode(value)
            case let .adminDefsModEventReport(value):
                try container.encode(value)
            case let .adminDefsModEventMute(value):
                try container.encode(value)
            case let .adminDefsModEventReverseTakedown(value):
                try container.encode(value)
            case let .adminDefsModEventUnmute(value):
                try container.encode(value)
            case let .adminDefsModEventEmail(value):
                try container.encode(value)
            }
        }
    }
    enum AdminEmitModerationEvent_Input_Subject: Codable {
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
    static func AdminEmitModerationEvent(input: AdminEmitModerationEvent_Input) async throws -> AdminDefs_ModEventView {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.admin.emitModerationEvent", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}