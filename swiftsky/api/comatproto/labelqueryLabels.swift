import SwiftAtproto
import Foundation
extension comatprototypes {
    class LabelQueryLabels_Output: Codable {
        let type = "com.atproto.label.queryLabels"
        var cursor: String?
        var labels: [LabelDefs_Label]
        init(cursor: String?, labels: [LabelDefs_Label]) {
            self.cursor = cursor
            self.labels = labels
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case cursor
            case labels
        }
    }
    static func LabelQueryLabels(cursor: String?, limit: Int?, sources: [String]?, uriPatterns: [String]) async throws -> LabelQueryLabels_Output {
        let params: Parameters = ["cursor": .string(cursor), "limit": .integer(limit), "sources": .array(sources), "uriPatterns": .array(uriPatterns)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.label.queryLabels", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}