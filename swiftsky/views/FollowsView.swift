//
//  FollowsView.swift
//  swiftsky
//

import SwiftUI

private struct FollowsRowView: View {
    @State var user: appbskytypes.ActorDefs_ProfileView
    @State var usernamehover: Bool = false
    @State var followingdisabled: Bool = false
    @Binding var path: [Navigation]
    func follow() {
        followingdisabled = true
        Task {
            do {
                let result = try await followUser(
                    did: user.did)
                user.viewer?.following = result.uri
            } catch {
                print(error)
            }
            followingdisabled = false
        }
    }

    func unfollow() {
        followingdisabled = true
        Task {
            do {
                let result = try await comatprototypes.RepoDeleteRecord(input: .init(
                    collection: "app.bsky.graph.follow",
                    repo: XRPCClient.shared.auth.did,
                    rkey: AtUri(uri: user.viewer!.following!).rkey,
                    swapCommit: nil,
                    swapRecord: nil
                ))
                if result {
                    user.viewer!.following = nil
                }
            } catch {
                print(error)
            }
            followingdisabled = false
        }
    }

    var body: some View {
        HStack(alignment: .top) {
            AvatarView(url: user.avatar, size: 40)
            let displayname = user.displayName ?? user.handle
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    Text(displayname)
                        .underline(usernamehover)
                        .hoverHand { usernamehover = $0 }
                    Text("@\(user.handle)").foregroundColor(.secondary)
                }
                .onTapGesture {
                    path.append(.profile(user.did))
                }
                if user.viewer?.followedBy != nil {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .opacity(0.04)
                        Text("Follows you")
                    }.padding(.top, 2)
                        .frame(maxWidth: 90)
                }
            }
            Spacer()
            if user.did != XRPCClient.shared.auth.did {
                let following = user.viewer?.following != nil
                Button {
                    following ? unfollow() : follow()
                } label: {
                    Group {
                        if !following {
                            Text("\(Image(systemName: "plus")) Follow")
                        } else {
                            Text("Unfollow")
                        }
                    }.frame(maxWidth: 60)
                }
                .disabled(followingdisabled)
                .buttonStyle(.borderedProminent)
                .tint(!following ? .accentColor : Color(.controlColor))
                .padding(.trailing, 2)
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
    }
}

struct FollowsView: View {
    let handle: String
    @State var follows: appbskytypes.GraphGetFollows_Output? = nil
    @Binding var path: [Navigation]
    func getFollows() async {
        do {
            follows = try await appbskytypes.GraphGetFollows(actor: handle, cursor: nil, limit: 30)
        } catch {}
    }

    func getMoreFollows(cursor: String) async {
        do {
            let result = try await appbskytypes.GraphGetFollows(actor: handle, cursor: cursor, limit: 30)
            follows = appbskytypes.GraphGetFollows_Output(
                cursor: result.cursor,
                follows: follows!.follows + result.follows, subject: result.subject
            )
        } catch {}
    }

    var body: some View {
        List {
            if let follows {
                ForEach(follows.follows) { user in
                    FollowsRowView(user: user, path: $path)
                        .padding(5)
                        .task {
                            if user === follows.follows.last {
                                if let cursor = follows.cursor {
                                    await getMoreFollows(cursor: cursor)
                                }
                            }
                        }
                    Divider()
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                if follows.cursor != nil {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .environment(\.defaultMinListRowHeight, 1)
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
        .task {
            await getFollows()
        }
    }
}
