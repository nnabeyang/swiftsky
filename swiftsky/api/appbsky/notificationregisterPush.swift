import SwiftAtproto
import Foundation
extension appbskytypes {
    class NotificationRegisterPush_Input: Codable {
        let type = "app.bsky.notification.registerPush"
        var appId: String
        var platform: String
        var serviceDid: String
        var token: String
        init(appId: String, platform: String, serviceDid: String, token: String) {
            self.appId = appId
            self.platform = platform
            self.serviceDid = serviceDid
            self.token = token
        }
        enum CodingKeys: String, CodingKey {
            case type = "$type"
            case appId
            case platform
            case serviceDid
            case token
        }
    }
    static func NotificationRegisterPush(input: NotificationRegisterPush_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await XRPCClient.shared.fetch(endpoint: "app.bsky.notification.registerPush", contentType: "application/json", httpMethod: .post, params: params, input: input)
    }
}