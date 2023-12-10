//
//  api.swift
//  swiftsky
//

import Combine
import Foundation
import SwiftAtproto
import SwiftUI

struct AnyKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
        intValue = nil
    }

    init?(intValue: Int) {
        stringValue = String(intValue)
        self.intValue = intValue
    }
}

struct xrpcErrorDescription: Error, LocalizedError, Decodable {
    let error: String?
    let message: String?
    var errorDescription: String? {
        message
    }
}

class XRPCClient: XRPCBaseClient {
    static let shared = {
        let client = XRPCClient(host: URL(string: "https://bsky.social")!)
        return client
    }()

    override func refreshSession() async -> Bool {
        do {
            let result = try await comatprototypes.ServerRefreshSession(client: XRPCClient.shared)
            auth.accessJwt = result.accessJwt
            auth.refreshJwt = result.refreshJwt
            auth.handle = result.handle
            auth.did = result.did
            auth.save()
            return true
        } catch {
            return false
        }
    }

    override func getAuthorization(endpoint: String) -> String {
        endpoint == "com.atproto.server.refreshSession" ? auth.refreshJwt : auth.accessJwt
    }

    func postInit(auth: AuthInfo) {
        self.auth = auth
        let group = DispatchGroup()
        group.enter()
        Task {
            do {
                let session = try await comatprototypes.ServerGetSession(client: XRPCClient.shared)
                if auth.did == session.did, auth.handle == session.handle {
                    Auth.shared.needAuthorization = false
                }
            } catch {}
            group.leave()
        }
        group.wait()
    }
}

extension AuthInfo {
    static func load() -> AuthInfo? {
        if let userdata = Keychain.get("app.swiftsky.userData"),
           let auth = try? JSONDecoder().decode(AuthInfo.self, from: userdata)
        {
            return auth
        }
        return nil
    }

    func save() {
        Task {
            if let userdata = try? JSONEncoder().encode(self) {
                Keychain.set(userdata, "app.swiftsky.userData")
            }
        }
    }
}

class Auth: ObservableObject {
    static let shared = Auth()
    @Published var needAuthorization: Bool = true
    public func signout() {
        GlobalViewModel.shared.profile = nil
        XRPCClient.shared.auth = AuthInfo()
        needAuthorization = true
        Task {
            Keychain.delete("app.swiftsky.userData")
        }
    }
}
