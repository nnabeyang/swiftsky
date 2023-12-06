//
//  SidebarView.swift
//  swiftsky
//

import SwiftUI

struct SidebarView: View {
    @EnvironmentObject private var auth: Auth
    @EnvironmentObject private var globalviewmodel: GlobalViewModel
    @EnvironmentObject private var pushnotifications: PushNotificatios
    @EnvironmentObject private var preferences: PreferencesModel
    @State private var selection: Navigation.Sidebar? = nil
    @State private var path: [Navigation] = []
    @State var compose: Bool = false
    @State var replypost: Bool = false
    @State private var post: FeedDefsPostView? = nil
    @State var searchactors = ActorSearchActorsTypeaheadOutput()
    @State var searchpresented = false
    @State var preferencesLoading = false
    @State var preferencesLoadingError: String? = nil
    func load() async {
        preferencesLoadingError = nil
        if !auth.needAuthorization {
            Task {
                globalviewmodel.profile = try? await actorgetProfile(actor: Client.shared.handle)
            }
            preferencesLoading = true
            do {
                try await preferences.sync()
                try await SavedFeedsModel.shared.updateCache()
            } catch {
                preferencesLoadingError = error.localizedDescription
            }
            preferencesLoading = false
        }
    }

    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                NavigationLink(value: Navigation.Sidebar.profile("")) {
                    HStack(spacing: 5) {
                        AvatarView(url: globalviewmodel.profile?.avatar, size: 40)
                        VStack(alignment: .leading, spacing: 0) {
                            if auth.needAuthorization || globalviewmodel.profile == nil {
                                Text("Sign in")
                            } else {
                                if let displayname = globalviewmodel.profile!.displayName {
                                    Text(displayname)
                                }
                                Text(globalviewmodel.profile!.handle)
                                    .font(.footnote)
                                    .opacity(0.6)
                            }
                        }
                    }
                }

                Section {
                    NavigationLink(value: Navigation.Sidebar.home) {
                        Label("Home", systemImage: "house")
                    }
                    NavigationLink(value: Navigation.Sidebar.notifications) {
                        Label("Notifications", systemImage: "bell.badge")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(alignment: .trailing) {
                                let unreadcount = pushnotifications.unreadcount
                                if unreadcount > 0 {
                                    Circle().fill(.red)
                                        .overlay {
                                            Text("\(unreadcount < 10 ? "\(unreadcount)" : "9+")")
                                                .font(.system(size: 11))
                                                .foregroundColor(.white)
                                        }
                                }
                            }
                    }
                }
                Section("Feeds") {
                    NavigationLink(value: Navigation.Sidebar.discoverfeeds) {
                        Label("Discover", systemImage: "doc.text.magnifyingglass")
                    }
                    ForEach(SavedFeedsModel.shared.pinned) { feed in
                        NavigationLink(value: Navigation.Sidebar.feed(feed)) {
                            Label(
                                title: { Text(feed.displayName) },
                                icon: { AvatarView(url: feed.avatar, size: 20, isFeed: true) }
                            )
                            .contextMenu {
                                Button("Remove from sidebar") {
                                    Task {
                                        await preferences.unpinfeed(uri: feed.uri)
                                    }
                                }
                                Button("Delete") {
                                    Task {
                                        await preferences.deletefeed(uri: feed.uri)
                                    }
                                }
                            }
                        }
                    }
                    .onMove(perform: { indices, newOffset in
                        var temp = preferences.pinnedFeeds
                        temp.move(fromOffsets: indices, toOffset: newOffset)
                        Task {
                            await preferences.setSavedFeeds(saved: preferences.savedFeeds, pinned: temp)
                        }
                    })
                    if preferencesLoading {
                        ProgressView().frame(maxWidth: .infinity, alignment: .center)
                    }
                    if let preferencesLoadingError {
                        ErrorView(error: preferencesLoadingError) {
                            Task {
                                await load()
                            }
                        }
                    }
                }
            }
            .frame(minWidth: 230)
            .listStyle(.sidebar)
        } detail: {
            NavigationStack(path: $path) {
                Group {
                    switch selection {
                    case .profile:
                        if let profile = globalviewmodel.profile {
                            ProfileView(did: profile.did, profile: profile, path: $path)
                                .navigationTitle(profile.handle)
                        } else {
                            EmptyView()
                        }

                    case .home:
                        HomeView(path: $path)
                            .navigationTitle("Home")
                    case .notifications:
                        NotificationsView(path: $path)
                            .navigationTitle("Notifications")
                    case let .feed(feed):
                        FeedView(model: feed, header: false, path: $path)
                            .navigationTitle(feed.displayName)
                    case .discoverfeeds:
                        DiscoverFeedsView(path: $path)
                            .navigationTitle("Discover Feeds")
                    default:
                        EmptyView()
                    }
                }
                .frame(minWidth: 200)
                .navigationDestination(for: Navigation.self) { destination in
                    Group {
                        switch destination {
                        case let .profile(did):
                            ProfileView(did: did, path: $path)
                        case let .thread(uri):
                            ThreadView(uri: uri, path: $path)
                        case let .followers(handle):
                            FollowersView(handle: handle, path: $path)
                                .navigationTitle("People following @\(handle)")
                        case let .following(handle):
                            FollowsView(handle: handle, path: $path)
                                .navigationTitle("People followed by @\(handle)")
                        case let .feed(feed):
                            FeedView(model: feed, header: true, path: $path)
                                .navigationTitle(feed.displayName)
                        }
                    }
                    .frame(minWidth: 200)
                }
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            compose = true
                        } label: {
                            Image(systemName: "square.and.pencil")
                        }
                        .sheet(isPresented: $compose) {
                            NewPostView()
                                .frame(width: 600)
                                .fixedSize()
                        }
                    }
                    ToolbarItem {
                        SearchField { search in
                            if !search.isEmpty {
                                do {
                                    searchactors = try await ActorSearchActorsTypeahead(term: search)
                                    searchpresented = !searchactors.actors.isEmpty
                                } catch {}
                            } else {
                                searchactors = .init()
                                searchpresented = false
                            }
                        }
                        .frame(width: 150)
                        .popover(isPresented: $searchpresented, arrowEdge: .bottom) {
                            SearchActorView(actorstypeahead: $searchactors) { user in
                                path.append(.profile(user.did))
                            }
                        }
                    }
                }
            }
        }
        .quickLookPreview($globalviewmodel.preview)
        .handlesExternalEvents(preferring: ["*"], allowing: ["*"])
        .onOpenURL(perform: { url in
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            let did = components?.queryItems?.first { $0.name == "did" }?.value
            guard let did else {
                return
            }

            path.append(.profile(did))
        })
        .onChange(of: selection) { _ in
            path.removeLast(path.count)
        }
        .task {
            selection = .home
            await load()
        }
    }
}
