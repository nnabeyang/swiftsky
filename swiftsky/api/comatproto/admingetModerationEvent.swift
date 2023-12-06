import SwiftAtproto
import Foundation
extension comatprototypes {
    static func AdminGetModerationEvent(id: Int) async throws -> AdminDefs_ModEventViewDetail {
        let params: Parameters = ["id": .integer(id)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.admin.getModerationEvent", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}