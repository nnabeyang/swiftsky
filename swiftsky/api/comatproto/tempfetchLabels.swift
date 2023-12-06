import SwiftAtproto
import Foundation
extension comatprototypes {
    class TempFetchLabels_Output: Codable {
        let type = "com.atproto.temp.fetchLabels"
        var labels: [LabelDefs_Label]
        init(labels: [LabelDefs_Label]) {
            self.labels = labels
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case labels
        }
    }
    static func TempFetchLabels(limit: Int?, since: Int?) async throws -> TempFetchLabels_Output {
        let params: Parameters = ["limit": .integer(limit), "since": .integer(since)]
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.temp.fetchLabels", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}