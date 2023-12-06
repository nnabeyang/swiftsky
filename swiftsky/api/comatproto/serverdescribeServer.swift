import SwiftAtproto
import Foundation
extension comatprototypes {
    class ServerDescribeServer_Links: Codable {
        let type = "com.atproto.server.describeServer#links"
        var privacyPolicy: String?
        var termsOfService: String?
        init(privacyPolicy: String?, termsOfService: String?) {
            self.privacyPolicy = privacyPolicy
            self.termsOfService = termsOfService
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case privacyPolicy
            case termsOfService
        }
    }
    class ServerDescribeServer_Output: Codable {
        let type = "com.atproto.server.describeServer"
        var availableUserDomains: [String]
        var inviteCodeRequired: Bool?
        var links: ServerDescribeServer_Links?
        init(availableUserDomains: [String], inviteCodeRequired: Bool?, links: ServerDescribeServer_Links?) {
            self.availableUserDomains = availableUserDomains
            self.inviteCodeRequired = inviteCodeRequired
            self.links = links
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case availableUserDomains
            case inviteCodeRequired
            case links
        }
    }
    static func ServerDescribeServer() async throws -> ServerDescribeServer_Output {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "com.atproto.server.describeServer", contentType: "*/*", httpMethod: .get, params: params, input: Bool?.none)
    }
}