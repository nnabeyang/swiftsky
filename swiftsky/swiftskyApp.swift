//
//  swiftskyApp.swift
//  swiftsky
//

import SwiftAtproto
import SwiftUI

@main
struct swiftskyApp: App {
    @StateObject private var auth = Auth.shared
    @StateObject private var globalviewmodel = GlobalViewModel.shared
    @StateObject private var pushnotifications = PushNotificatios.shared
    @StateObject private var preferences = PreferencesModel.shared
    init() {
        if let auth = AuthInfo.load() {
            XRPCClient.shared.postInit(auth: auth)
            Auth.shared.needAuthorization = false
        }
        LexiconTypesMap.shared.register(id: "app.bsky.feed.post", val: appbskytypes.FeedPost.self)
        LexiconTypesMap.shared.register(id: "app.bsky.feed.like", val: appbskytypes.FeedPost.self)
        LexiconTypesMap.shared.register(id: "app.bsky.graph.follow", val: appbskytypes.GraphFollow.self)
        LexiconTypesMap.shared.register(id: "app.bsky.graph.block", val: appbskytypes.GraphBlock.self)
        GlobalViewModel.shared.systemLanguageCode = Locale.preferredLanguageCodes[0]
        GlobalViewModel.shared.systemLanguage = Locale.current.localizedString(forLanguageCode: GlobalViewModel.shared.systemLanguageCode) ?? "en"
    }

    var body: some Scene {
        WindowGroup {
            SidebarView().sheet(isPresented: $auth.needAuthorization) {
                LoginView()
            }
            .environmentObject(auth)
            .environmentObject(globalviewmodel)
            .environmentObject(pushnotifications)
            .environmentObject(preferences)
        }
        .defaultSize(width: 1100, height: 650)
        .commands {
            CommandMenu("Account") {
                if let profile = globalviewmodel.profile {
                    Text("@\(profile.handle)")
                    Button("Sign out") {
                        auth.signout()
                    }
                }
            }
        }
        .onChange(of: auth.needAuthorization) {
            if !$0 {
                pushnotifications.resumeRefreshTask()
                Task {
                    globalviewmodel.profile = try? await appbskytypes.ActorGetProfile(client: XRPCClient.shared, actor: XRPCClient.shared.auth.handle)
                }
            } else {
                pushnotifications.cancelRefreshTask()
            }
        }
        Settings {
            SettingsView()
        }
    }
}
