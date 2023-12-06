import SwiftAtproto
import Foundation
extension comatprototypes {
    class AdminDefs_AccountView: Codable {
        let type = "com.atproto.admin.defs#accountView"
        var did: String
        var email: String?
        var emailConfirmedAt: String?
        var handle: String
        var indexedAt: String
        var inviteNote: String?
        var invitedBy: ServerDefs_InviteCode?
        var invites: [ServerDefs_InviteCode]?
        var invitesDisabled: Bool?
        init(did: String, email: String?, emailConfirmedAt: String?, handle: String, indexedAt: String, inviteNote: String?, invitedBy: ServerDefs_InviteCode?, invites: [ServerDefs_InviteCode]?, invitesDisabled: Bool?) {
            self.did = did
            self.email = email
            self.emailConfirmedAt = emailConfirmedAt
            self.handle = handle
            self.indexedAt = indexedAt
            self.inviteNote = inviteNote
            self.invitedBy = invitedBy
            self.invites = invites
            self.invitesDisabled = invitesDisabled
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
            case email
            case emailConfirmedAt
            case handle
            case indexedAt
            case inviteNote
            case invitedBy
            case invites
            case invitesDisabled
        }
    }
    class AdminDefs_BlobView: Codable {
        let type = "com.atproto.admin.defs#blobView"
        var cid: String
        var createdAt: String
        var details: AdminDefs_BlobView_Details?
        var mimeType: String
        var moderation: AdminDefs_Moderation?
        var size: Int
        init(cid: String, createdAt: String, details: AdminDefs_BlobView_Details?, mimeType: String, moderation: AdminDefs_Moderation?, size: Int) {
            self.cid = cid
            self.createdAt = createdAt
            self.details = details
            self.mimeType = mimeType
            self.moderation = moderation
            self.size = size
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cid
            case createdAt
            case details
            case mimeType
            case moderation
            case size
        }
    }
    enum AdminDefs_BlobView_Details: Codable {
        case adminDefsImageDetails(AdminDefs_ImageDetails)
        case adminDefsVideoDetails(AdminDefs_VideoDetails)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "com.atproto.admin.defs#imageDetails":
                self = try .adminDefsImageDetails(.init(from: decoder))
            case "com.atproto.admin.defs#videoDetails":
                self = try .adminDefsVideoDetails(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .adminDefsImageDetails(value):
                try container.encode(value)
            case let .adminDefsVideoDetails(value):
                try container.encode(value)
            }
        }
    }
    class AdminDefs_ImageDetails: Codable {
        let type = "com.atproto.admin.defs#imageDetails"
        var height: Int
        var width: Int
        init(height: Int, width: Int) {
            self.height = height
            self.width = width
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case height
            case width
        }
    }
    class AdminDefs_Moderation: Codable {
        let type = "com.atproto.admin.defs#moderation"
        var subjectStatus: AdminDefs_SubjectStatusView?
        init(subjectStatus: AdminDefs_SubjectStatusView?) {
            self.subjectStatus = subjectStatus
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case subjectStatus
        }
    }
    class AdminDefs_ModerationDetail: Codable {
        let type = "com.atproto.admin.defs#moderationDetail"
        var subjectStatus: AdminDefs_SubjectStatusView?
        init(subjectStatus: AdminDefs_SubjectStatusView?) {
            self.subjectStatus = subjectStatus
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case subjectStatus
        }
    }
    class AdminDefs_ModEventAcknowledge: Codable {
        let type = "com.atproto.admin.defs#modEventAcknowledge"
        var comment: String?
        init(comment: String?) {
            self.comment = comment
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case comment
        }
    }
    class AdminDefs_ModEventComment: Codable {
        let type = "com.atproto.admin.defs#modEventComment"
        var comment: String
        var sticky: Bool?
        init(comment: String, sticky: Bool?) {
            self.comment = comment
            self.sticky = sticky
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case comment
            case sticky
        }
    }
    class AdminDefs_ModEventEmail: Codable {
        let type = "com.atproto.admin.defs#modEventEmail"
        var subjectLine: String
        init(subjectLine: String) {
            self.subjectLine = subjectLine
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case subjectLine
        }
    }
    class AdminDefs_ModEventEscalate: Codable {
        let type = "com.atproto.admin.defs#modEventEscalate"
        var comment: String?
        init(comment: String?) {
            self.comment = comment
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case comment
        }
    }
    class AdminDefs_ModEventLabel: Codable {
        let type = "com.atproto.admin.defs#modEventLabel"
        var comment: String?
        var createLabelVals: [String]
        var negateLabelVals: [String]
        init(comment: String?, createLabelVals: [String], negateLabelVals: [String]) {
            self.comment = comment
            self.createLabelVals = createLabelVals
            self.negateLabelVals = negateLabelVals
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case comment
            case createLabelVals
            case negateLabelVals
        }
    }
    class AdminDefs_ModEventMute: Codable {
        let type = "com.atproto.admin.defs#modEventMute"
        var comment: String?
        var durationInHours: Int
        init(comment: String?, durationInHours: Int) {
            self.comment = comment
            self.durationInHours = durationInHours
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case comment
            case durationInHours
        }
    }
    class AdminDefs_ModEventReport: Codable {
        let type = "com.atproto.admin.defs#modEventReport"
        var comment: String?
        var reportType: String
        init(comment: String?, reportType: String) {
            self.comment = comment
            self.reportType = reportType
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case comment
            case reportType
        }
    }
    class AdminDefs_ModEventReverseTakedown: Codable {
        let type = "com.atproto.admin.defs#modEventReverseTakedown"
        var comment: String?
        init(comment: String?) {
            self.comment = comment
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case comment
        }
    }
    class AdminDefs_ModEventTakedown: Codable {
        let type = "com.atproto.admin.defs#modEventTakedown"
        var comment: String?
        var durationInHours: Int?
        init(comment: String?, durationInHours: Int?) {
            self.comment = comment
            self.durationInHours = durationInHours
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case comment
            case durationInHours
        }
    }
    class AdminDefs_ModEventUnmute: Codable {
        let type = "com.atproto.admin.defs#modEventUnmute"
        var comment: String?
        init(comment: String?) {
            self.comment = comment
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case comment
        }
    }
    class AdminDefs_ModEventView: Codable {
        let type = "com.atproto.admin.defs#modEventView"
        var createdAt: String
        var createdBy: String
        var creatorHandle: String?
        var event: AdminDefs_ModEventView_Event
        var id: Int
        var subject: AdminDefs_ModEventView_Subject
        var subjectBlobCids: [String]
        var subjectHandle: String?
        init(createdAt: String, createdBy: String, creatorHandle: String?, event: AdminDefs_ModEventView_Event, id: Int, subject: AdminDefs_ModEventView_Subject, subjectBlobCids: [String], subjectHandle: String?) {
            self.createdAt = createdAt
            self.createdBy = createdBy
            self.creatorHandle = creatorHandle
            self.event = event
            self.id = id
            self.subject = subject
            self.subjectBlobCids = subjectBlobCids
            self.subjectHandle = subjectHandle
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case createdAt
            case createdBy
            case creatorHandle
            case event
            case id
            case subject
            case subjectBlobCids
            case subjectHandle
        }
    }
    enum AdminDefs_ModEventView_Event: Codable {
        case adminDefsModEventTakedown(AdminDefs_ModEventTakedown)
        case adminDefsModEventReverseTakedown(AdminDefs_ModEventReverseTakedown)
        case adminDefsModEventComment(AdminDefs_ModEventComment)
        case adminDefsModEventReport(AdminDefs_ModEventReport)
        case adminDefsModEventLabel(AdminDefs_ModEventLabel)
        case adminDefsModEventAcknowledge(AdminDefs_ModEventAcknowledge)
        case adminDefsModEventEscalate(AdminDefs_ModEventEscalate)
        case adminDefsModEventMute(AdminDefs_ModEventMute)
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
            case "com.atproto.admin.defs#modEventReverseTakedown":
                self = try .adminDefsModEventReverseTakedown(.init(from: decoder))
            case "com.atproto.admin.defs#modEventComment":
                self = try .adminDefsModEventComment(.init(from: decoder))
            case "com.atproto.admin.defs#modEventReport":
                self = try .adminDefsModEventReport(.init(from: decoder))
            case "com.atproto.admin.defs#modEventLabel":
                self = try .adminDefsModEventLabel(.init(from: decoder))
            case "com.atproto.admin.defs#modEventAcknowledge":
                self = try .adminDefsModEventAcknowledge(.init(from: decoder))
            case "com.atproto.admin.defs#modEventEscalate":
                self = try .adminDefsModEventEscalate(.init(from: decoder))
            case "com.atproto.admin.defs#modEventMute":
                self = try .adminDefsModEventMute(.init(from: decoder))
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
            case let .adminDefsModEventReverseTakedown(value):
                try container.encode(value)
            case let .adminDefsModEventComment(value):
                try container.encode(value)
            case let .adminDefsModEventReport(value):
                try container.encode(value)
            case let .adminDefsModEventLabel(value):
                try container.encode(value)
            case let .adminDefsModEventAcknowledge(value):
                try container.encode(value)
            case let .adminDefsModEventEscalate(value):
                try container.encode(value)
            case let .adminDefsModEventMute(value):
                try container.encode(value)
            case let .adminDefsModEventEmail(value):
                try container.encode(value)
            }
        }
    }
    enum AdminDefs_ModEventView_Subject: Codable {
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
    class AdminDefs_ModEventViewDetail: Codable {
        let type = "com.atproto.admin.defs#modEventViewDetail"
        var createdAt: String
        var createdBy: String
        var event: AdminDefs_ModEventViewDetail_Event
        var id: Int
        var subject: AdminDefs_ModEventViewDetail_Subject
        var subjectBlobs: [AdminDefs_BlobView]
        init(createdAt: String, createdBy: String, event: AdminDefs_ModEventViewDetail_Event, id: Int, subject: AdminDefs_ModEventViewDetail_Subject, subjectBlobs: [AdminDefs_BlobView]) {
            self.createdAt = createdAt
            self.createdBy = createdBy
            self.event = event
            self.id = id
            self.subject = subject
            self.subjectBlobs = subjectBlobs
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case createdAt
            case createdBy
            case event
            case id
            case subject
            case subjectBlobs
        }
    }
    enum AdminDefs_ModEventViewDetail_Event: Codable {
        case adminDefsModEventTakedown(AdminDefs_ModEventTakedown)
        case adminDefsModEventReverseTakedown(AdminDefs_ModEventReverseTakedown)
        case adminDefsModEventComment(AdminDefs_ModEventComment)
        case adminDefsModEventReport(AdminDefs_ModEventReport)
        case adminDefsModEventLabel(AdminDefs_ModEventLabel)
        case adminDefsModEventAcknowledge(AdminDefs_ModEventAcknowledge)
        case adminDefsModEventEscalate(AdminDefs_ModEventEscalate)
        case adminDefsModEventMute(AdminDefs_ModEventMute)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "com.atproto.admin.defs#modEventTakedown":
                self = try .adminDefsModEventTakedown(.init(from: decoder))
            case "com.atproto.admin.defs#modEventReverseTakedown":
                self = try .adminDefsModEventReverseTakedown(.init(from: decoder))
            case "com.atproto.admin.defs#modEventComment":
                self = try .adminDefsModEventComment(.init(from: decoder))
            case "com.atproto.admin.defs#modEventReport":
                self = try .adminDefsModEventReport(.init(from: decoder))
            case "com.atproto.admin.defs#modEventLabel":
                self = try .adminDefsModEventLabel(.init(from: decoder))
            case "com.atproto.admin.defs#modEventAcknowledge":
                self = try .adminDefsModEventAcknowledge(.init(from: decoder))
            case "com.atproto.admin.defs#modEventEscalate":
                self = try .adminDefsModEventEscalate(.init(from: decoder))
            case "com.atproto.admin.defs#modEventMute":
                self = try .adminDefsModEventMute(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .adminDefsModEventTakedown(value):
                try container.encode(value)
            case let .adminDefsModEventReverseTakedown(value):
                try container.encode(value)
            case let .adminDefsModEventComment(value):
                try container.encode(value)
            case let .adminDefsModEventReport(value):
                try container.encode(value)
            case let .adminDefsModEventLabel(value):
                try container.encode(value)
            case let .adminDefsModEventAcknowledge(value):
                try container.encode(value)
            case let .adminDefsModEventEscalate(value):
                try container.encode(value)
            case let .adminDefsModEventMute(value):
                try container.encode(value)
            }
        }
    }
    enum AdminDefs_ModEventViewDetail_Subject: Codable {
        case adminDefsRepoView(AdminDefs_RepoView)
        case adminDefsRepoViewNotFound(AdminDefs_RepoViewNotFound)
        case adminDefsRecordView(AdminDefs_RecordView)
        case adminDefsRecordViewNotFound(AdminDefs_RecordViewNotFound)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "com.atproto.admin.defs#repoView":
                self = try .adminDefsRepoView(.init(from: decoder))
            case "com.atproto.admin.defs#repoViewNotFound":
                self = try .adminDefsRepoViewNotFound(.init(from: decoder))
            case "com.atproto.admin.defs#recordView":
                self = try .adminDefsRecordView(.init(from: decoder))
            case "com.atproto.admin.defs#recordViewNotFound":
                self = try .adminDefsRecordViewNotFound(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .adminDefsRepoView(value):
                try container.encode(value)
            case let .adminDefsRepoViewNotFound(value):
                try container.encode(value)
            case let .adminDefsRecordView(value):
                try container.encode(value)
            case let .adminDefsRecordViewNotFound(value):
                try container.encode(value)
            }
        }
    }
    class AdminDefs_RecordView: Codable {
        let type = "com.atproto.admin.defs#recordView"
        var blobCids: [String]
        var cid: String
        var indexedAt: String
        var moderation: AdminDefs_Moderation
        var repo: AdminDefs_RepoView
        var uri: String
        var value: LexiconTypeDecoder
        init(blobCids: [String], cid: String, indexedAt: String, moderation: AdminDefs_Moderation, repo: AdminDefs_RepoView, uri: String, value: LexiconTypeDecoder) {
            self.blobCids = blobCids
            self.cid = cid
            self.indexedAt = indexedAt
            self.moderation = moderation
            self.repo = repo
            self.uri = uri
            self.value = value
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case blobCids
            case cid
            case indexedAt
            case moderation
            case repo
            case uri
            case value
        }
    }
    class AdminDefs_RecordViewDetail: Codable {
        let type = "com.atproto.admin.defs#recordViewDetail"
        var blobs: [AdminDefs_BlobView]
        var cid: String
        var indexedAt: String
        var labels: [LabelDefs_Label]?
        var moderation: AdminDefs_ModerationDetail
        var repo: AdminDefs_RepoView
        var uri: String
        var value: LexiconTypeDecoder
        init(blobs: [AdminDefs_BlobView], cid: String, indexedAt: String, labels: [LabelDefs_Label]?, moderation: AdminDefs_ModerationDetail, repo: AdminDefs_RepoView, uri: String, value: LexiconTypeDecoder) {
            self.blobs = blobs
            self.cid = cid
            self.indexedAt = indexedAt
            self.labels = labels
            self.moderation = moderation
            self.repo = repo
            self.uri = uri
            self.value = value
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case blobs
            case cid
            case indexedAt
            case labels
            case moderation
            case repo
            case uri
            case value
        }
    }
    class AdminDefs_RecordViewNotFound: Codable {
        let type = "com.atproto.admin.defs#recordViewNotFound"
        var uri: String
        init(uri: String) {
            self.uri = uri
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case uri
        }
    }
    class AdminDefs_RepoBlobRef: Codable {
        let type = "com.atproto.admin.defs#repoBlobRef"
        var cid: String
        var did: String
        var recordUri: String?
        init(cid: String, did: String, recordUri: String?) {
            self.cid = cid
            self.did = did
            self.recordUri = recordUri
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cid
            case did
            case recordUri
        }
    }
    class AdminDefs_RepoRef: Codable {
        let type = "com.atproto.admin.defs#repoRef"
        var did: String
        init(did: String) {
            self.did = did
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
        }
    }
    class AdminDefs_ReportView: Codable {
        let type = "com.atproto.admin.defs#reportView"
        var comment: String?
        var createdAt: String
        var id: Int
        var reasonType: String
        var reportedBy: String
        var resolvedByActionIds: [Int]
        var subject: AdminDefs_ReportView_Subject
        var subjectRepoHandle: String?
        init(comment: String?, createdAt: String, id: Int, reasonType: String, reportedBy: String, resolvedByActionIds: [Int], subject: AdminDefs_ReportView_Subject, subjectRepoHandle: String?) {
            self.comment = comment
            self.createdAt = createdAt
            self.id = id
            self.reasonType = reasonType
            self.reportedBy = reportedBy
            self.resolvedByActionIds = resolvedByActionIds
            self.subject = subject
            self.subjectRepoHandle = subjectRepoHandle
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case comment
            case createdAt
            case id
            case reasonType
            case reportedBy
            case resolvedByActionIds
            case subject
            case subjectRepoHandle
        }
    }
    enum AdminDefs_ReportView_Subject: Codable {
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
    class AdminDefs_ReportViewDetail: Codable {
        let type = "com.atproto.admin.defs#reportViewDetail"
        var comment: String?
        var createdAt: String
        var id: Int
        var reasonType: String
        var reportedBy: String
        var resolvedByActions: [AdminDefs_ModEventView]
        var subject: AdminDefs_ReportViewDetail_Subject
        var subjectStatus: AdminDefs_SubjectStatusView?
        init(comment: String?, createdAt: String, id: Int, reasonType: String, reportedBy: String, resolvedByActions: [AdminDefs_ModEventView], subject: AdminDefs_ReportViewDetail_Subject, subjectStatus: AdminDefs_SubjectStatusView?) {
            self.comment = comment
            self.createdAt = createdAt
            self.id = id
            self.reasonType = reasonType
            self.reportedBy = reportedBy
            self.resolvedByActions = resolvedByActions
            self.subject = subject
            self.subjectStatus = subjectStatus
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case comment
            case createdAt
            case id
            case reasonType
            case reportedBy
            case resolvedByActions
            case subject
            case subjectStatus
        }
    }
    enum AdminDefs_ReportViewDetail_Subject: Codable {
        case adminDefsRepoView(AdminDefs_RepoView)
        case adminDefsRepoViewNotFound(AdminDefs_RepoViewNotFound)
        case adminDefsRecordView(AdminDefs_RecordView)
        case adminDefsRecordViewNotFound(AdminDefs_RecordViewNotFound)
        enum CodingKeys: String, CodingKey {
            case type = "$type"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(String.self, forKey: .type)
            switch type {
            case "com.atproto.admin.defs#repoView":
                self = try .adminDefsRepoView(.init(from: decoder))
            case "com.atproto.admin.defs#repoViewNotFound":
                self = try .adminDefsRepoViewNotFound(.init(from: decoder))
            case "com.atproto.admin.defs#recordView":
                self = try .adminDefsRecordView(.init(from: decoder))
            case "com.atproto.admin.defs#recordViewNotFound":
                self = try .adminDefsRecordViewNotFound(.init(from: decoder))
            default:
                fatalError()
            }
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .adminDefsRepoView(value):
                try container.encode(value)
            case let .adminDefsRepoViewNotFound(value):
                try container.encode(value)
            case let .adminDefsRecordView(value):
                try container.encode(value)
            case let .adminDefsRecordViewNotFound(value):
                try container.encode(value)
            }
        }
    }
    class AdminDefs_RepoView: Codable {
        let type = "com.atproto.admin.defs#repoView"
        var did: String
        var email: String?
        var handle: String
        var indexedAt: String
        var inviteNote: String?
        var invitedBy: ServerDefs_InviteCode?
        var invitesDisabled: Bool?
        var moderation: AdminDefs_Moderation
        var relatedRecords: [LexiconTypeDecoder]
        init(did: String, email: String?, handle: String, indexedAt: String, inviteNote: String?, invitedBy: ServerDefs_InviteCode?, invitesDisabled: Bool?, moderation: AdminDefs_Moderation, relatedRecords: [LexiconTypeDecoder]) {
            self.did = did
            self.email = email
            self.handle = handle
            self.indexedAt = indexedAt
            self.inviteNote = inviteNote
            self.invitedBy = invitedBy
            self.invitesDisabled = invitesDisabled
            self.moderation = moderation
            self.relatedRecords = relatedRecords
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
            case email
            case handle
            case indexedAt
            case inviteNote
            case invitedBy
            case invitesDisabled
            case moderation
            case relatedRecords
        }
    }
    class AdminDefs_RepoViewDetail: Codable {
        let type = "com.atproto.admin.defs#repoViewDetail"
        var did: String
        var email: String?
        var emailConfirmedAt: String?
        var handle: String
        var indexedAt: String
        var inviteNote: String?
        var invitedBy: ServerDefs_InviteCode?
        var invites: [ServerDefs_InviteCode]?
        var invitesDisabled: Bool?
        var labels: [LabelDefs_Label]?
        var moderation: AdminDefs_ModerationDetail
        var relatedRecords: [LexiconTypeDecoder]
        init(did: String, email: String?, emailConfirmedAt: String?, handle: String, indexedAt: String, inviteNote: String?, invitedBy: ServerDefs_InviteCode?, invites: [ServerDefs_InviteCode]?, invitesDisabled: Bool?, labels: [LabelDefs_Label]?, moderation: AdminDefs_ModerationDetail, relatedRecords: [LexiconTypeDecoder]) {
            self.did = did
            self.email = email
            self.emailConfirmedAt = emailConfirmedAt
            self.handle = handle
            self.indexedAt = indexedAt
            self.inviteNote = inviteNote
            self.invitedBy = invitedBy
            self.invites = invites
            self.invitesDisabled = invitesDisabled
            self.labels = labels
            self.moderation = moderation
            self.relatedRecords = relatedRecords
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
            case email
            case emailConfirmedAt
            case handle
            case indexedAt
            case inviteNote
            case invitedBy
            case invites
            case invitesDisabled
            case labels
            case moderation
            case relatedRecords
        }
    }
    class AdminDefs_RepoViewNotFound: Codable {
        let type = "com.atproto.admin.defs#repoViewNotFound"
        var did: String
        init(did: String) {
            self.did = did
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case did
        }
    }
    class AdminDefs_StatusAttr: Codable {
        let type = "com.atproto.admin.defs#statusAttr"
        var applied: Bool
        var ref: String?
        init(applied: Bool, ref: String?) {
            self.applied = applied
            self.ref = ref
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case applied
            case ref
        }
    }
    class AdminDefs_SubjectStatusView: Codable {
        let type = "com.atproto.admin.defs#subjectStatusView"
        var comment: String?
        var createdAt: String
        var id: Int
        var lastReportedAt: String?
        var lastReviewedAt: String?
        var lastReviewedBy: String?
        var muteUntil: String?
        var reviewState: String
        var subject: AdminDefs_SubjectStatusView_Subject
        var subjectBlobCids: [String]?
        var subjectRepoHandle: String?
        var suspendUntil: String?
        var takendown: Bool?
        var updatedAt: String
        init(comment: String?, createdAt: String, id: Int, lastReportedAt: String?, lastReviewedAt: String?, lastReviewedBy: String?, muteUntil: String?, reviewState: String, subject: AdminDefs_SubjectStatusView_Subject, subjectBlobCids: [String]?, subjectRepoHandle: String?, suspendUntil: String?, takendown: Bool?, updatedAt: String) {
            self.comment = comment
            self.createdAt = createdAt
            self.id = id
            self.lastReportedAt = lastReportedAt
            self.lastReviewedAt = lastReviewedAt
            self.lastReviewedBy = lastReviewedBy
            self.muteUntil = muteUntil
            self.reviewState = reviewState
            self.subject = subject
            self.subjectBlobCids = subjectBlobCids
            self.subjectRepoHandle = subjectRepoHandle
            self.suspendUntil = suspendUntil
            self.takendown = takendown
            self.updatedAt = updatedAt
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case comment
            case createdAt
            case id
            case lastReportedAt
            case lastReviewedAt
            case lastReviewedBy
            case muteUntil
            case reviewState
            case subject
            case subjectBlobCids
            case subjectRepoHandle
            case suspendUntil
            case takendown
            case updatedAt
        }
    }
    enum AdminDefs_SubjectStatusView_Subject: Codable {
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
    class AdminDefs_VideoDetails: Codable {
        let type = "com.atproto.admin.defs#videoDetails"
        var height: Int
        var length: Int
        var width: Int
        init(height: Int, length: Int, width: Int) {
            self.height = height
            self.length = length
            self.width = width
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case height
            case length
            case width
        }
    }
}