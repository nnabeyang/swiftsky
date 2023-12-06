import SwiftAtproto
import Foundation
extension comatprototypes {
    class AdminQueryModerationEvents_Output: Codable {
        let type = "com.atproto.admin.queryModerationEvents"
        var cursor: String?
        var events: [AdminDefs_ModEventView]
        init(cursor: String?, events: [AdminDefs_ModEventView]) {
            self.cursor = cursor
            self.events = events
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cursor
            case events
        }
    }
    static func AdminQueryModerationEvents(createdBy: String?, cursor: String?, includeAllUserRecords: Bool?, limit: Int?, sortDirection: String?, subject: String?, types: [String]?) async throws -> AdminQueryModerationEvents_Output {
        let params: Parameters = ["createdBy": .string(createdBy), "cursor": .string(cursor), "includeAllUserRecords": .bool(includeAllUserRecords), "limit": .integer(limit), "sortDirection": .string(sortDirection), "subject": .string(subject), "types": .array(types)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.admin.queryModerationEvents", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}