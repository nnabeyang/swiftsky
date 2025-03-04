//
// DO NOT EDIT
//
// Generated by swift-atproto
//

import SwiftAtproto
import Foundation

extension appbskytypes {
    class NotificationRegisterPush_Input: Codable {
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
            case appId
            case platform
            case serviceDid
            case token
        }
    }

    static func NotificationRegisterPush(client: any XRPCClientProtocol, input: NotificationRegisterPush_Input) async throws -> Bool {
        let params: Bool? = nil
        return try await client.fetch(endpoint: "app.bsky.notification.registerPush", contentType: "application/json", httpMethod: .post, params: params, input: input, retry: true)
    }
}
