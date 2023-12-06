//
//  ProfilePreview.swift
//  swiftsky
//

import SwiftUI

struct ProfilePreview: View {
    let did: String
    @State private var profile: appbskytypes.ActorDefs_ProfileViewDetailed?
    @State private var height = 50.0
    @State private var loading = false
    @State private var usernamehover = false
    @State private var handlehover = false
    @State private var disablefollowbutton = false
    @State private var error = ""
    @Binding var path: [Navigation]
    func load() async {
        loading = true
        do {
            profile = try await appbskytypes.ActorGetProfile(actor: did)
        } catch {
            self.error = error.localizedDescription
        }
        loading = false
    }

    private func follow() {
        disablefollowbutton = true
        Task {
            if let result = try? await followUser(
                did: did)
            {
                profile?.viewer?.following = result.uri
                profile?.followersCount? += 1
            }
            disablefollowbutton = false
        }
    }

    private func unfollow() {
        disablefollowbutton = true
        Task {
            let result = try await comatprototypes.RepoDeleteRecord(input: .init(
                collection: "app.bsky.graph.follow",
                repo: XRPCClient.shared.auth.did,
                rkey: AtUri(uri: profile!.viewer!.following!).rkey,
                swapCommit: nil,
                swapRecord: nil
            ))
            if result == true {
                profile!.viewer!.following = nil
                profile!.followersCount? -= 1
            }
            disablefollowbutton = false
        }
    }

    var body: some View {
        Group {
            if loading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            if !error.isEmpty {
                VStack {
                    Text("Error: \(error)")
                    Button("\(Image(systemName: "arrow.clockwise")) Retry") {
                        error = ""
                        Task {
                            await load()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            if let profile {
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        AvatarView(url: profile.avatar, size: 40)
                        Spacer()
                        if profile.did != XRPCClient.shared.auth.did {
                            Button(profile.viewer?.following != nil ? "Following" : "Follow") {
                                profile.viewer?.following != nil ? unfollow() : follow()
                            }
                            .disabled(disablefollowbutton)
                        }
                    }
                    Button {
                        path.append(.profile(did))
                    } label: {
                        Text(profile.displayName ?? profile.handle)
                            .lineLimit(1)
                            .underline(usernamehover)
                            .hoverHand {
                                usernamehover = $0
                            }
                    }
                    .buttonStyle(.plain)
                    Button {
                        path.append(.profile(did))
                    } label: {
                        Text("@\(profile.handle)").opacity(0.5)
                            .lineLimit(1)
                            .underline(handlehover)
                            .hoverHand {
                                handlehover = $0
                            }
                    }
                    .buttonStyle(.plain)
                    .lineLimit(1)
                    if let description = profile.description {
                        Text(description)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(3)
                    }
                    HStack {
                        Button {
                            path.append(.followers(profile.handle))
                        } label: {
                            HStack(spacing: 0) {
                                Text("\(profile.followersCount ?? 0) ")
                                Text("followers").opacity(0.5)
                            }
                        }
                        .buttonStyle(.plain)
                        Button {
                            path.append(.following(profile.handle))
                        } label: {
                            HStack(spacing: 0) {
                                Text("\(profile.followsCount ?? 0) ")
                                Text("following").opacity(0.5)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(10)
                .background {
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                height = proxy.size.height
                            }
                    }
                }
            }
        }
        .frame(width: 230, height: height, alignment: .topLeading)
        .task {
            await load()
        }
    }
}
