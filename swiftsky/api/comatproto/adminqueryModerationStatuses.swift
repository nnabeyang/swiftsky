//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension comatprototypes {
    class AdminQueryModerationStatuses_Output: Codable {
        var cursor: String?
        var subjectStatuses: [AdminDefs_SubjectStatusView]

        init(cursor: String?, subjectStatuses: [AdminDefs_SubjectStatusView]) {
            self.cursor = cursor
            self.subjectStatuses = subjectStatuses
        }

        enum CodingKeys: String, CodingKey {
            case cursor
            case subjectStatuses
        }
    }

    static func AdminQueryModerationStatuses(client: any XRPCClientProtocol, comment: String?, cursor: String?, ignoreSubjects: [String]?, includeMuted: Bool?, lastReviewedBy: String?, limit: Int?, reportedAfter: String?, reportedBefore: String?, reviewState: String?, reviewedAfter: String?, reviewedBefore: String?, sortDirection: String?, sortField: String?, subject: String?, takendown: Bool?) async throws -> AdminQueryModerationStatuses_Output {
        let params: Parameters = ["comment": .string(comment), "cursor": .string(cursor), "ignoreSubjects": .array(ignoreSubjects), "includeMuted": .bool(includeMuted), "lastReviewedBy": .string(lastReviewedBy), "limit": .integer(limit), "reportedAfter": .string(reportedAfter), "reportedBefore": .string(reportedBefore), "reviewState": .string(reviewState), "reviewedAfter": .string(reviewedAfter), "reviewedBefore": .string(reviewedBefore), "sortDirection": .string(sortDirection), "sortField": .string(sortField), "subject": .string(subject), "takendown": .bool(takendown)]
        return try await client.fetch(endpoint: "com.atproto.admin.queryModerationStatuses", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none, retry: true)
    }
}
