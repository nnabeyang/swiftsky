//
//  NotificationsView.swift
//  swiftsky
//

import SwiftUI

private struct NotificationsViewFollow: View {
    @State var notification: appbskytypes.NotificationListNotifications_Notification
    @State var underline = false
    @Binding var path: [Navigation]
    var body: some View {
        Group {
            let author = notification.author
            HStack {
                Image(systemName: "person.crop.circle.badge.plus")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .padding(5)
                    .clipped()
                    .foregroundColor(.accentColor)
                AvatarView(url: author.avatar, size: 40)
                HStack(spacing: 3) {
                    Button {
                        path.append(.profile(author.did))
                    } label: {
                        Text("@\(author.handle)")
                            .foregroundColor(.primary)
                            .underline(underline)
                            .hoverHand {
                                underline = $0
                            }
                            .tooltip {
                                ProfilePreview(did: author.did, path: $path)
                            }

                    }.buttonStyle(.plain)
                    Text("followed you")
                        .opacity(0.8)

                    Text(
                        notification.indexedAt
                    )
                    .font(.body)
                    .foregroundColor(.secondary)
                    .help(notification.indexedAt)
                }
            }
        }
    }
}

private struct NotificationsViewRepost: View {
    @State var notification: appbskytypes.NotificationListNotifications_Notification
    @State var underline = false
    @Binding var path: [Navigation]
    var body: some View {
        Group {
            let author = notification.author
            HStack {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .padding(5)
                    .clipped()
                    .foregroundColor(.accentColor)
                AvatarView(url: author.avatar, size: 40)
                HStack(spacing: 3) {
                    Button {
                        path.append(.profile(author.did))
                    } label: {
                        Text("@\(author.handle)")
                            .foregroundColor(.primary)
                            .underline(underline)
                            .hoverHand {
                                underline = $0
                            }
                            .tooltip {
                                ProfilePreview(did: author.did, path: $path)
                            }

                    }.buttonStyle(.plain)
                    Text("reposted your post")
                        .opacity(0.8)

                    Text(
                        notification.indexedAt
                    )
                    .font(.body)
                    .foregroundColor(.secondary)
                    .help(notification.indexedAt)
                }
            }
        }
    }
}

private struct NotificationsViewLike: View {
    @State var notification: appbskytypes.NotificationListNotifications_Notification
    @State var underline = false
    @Binding var path: [Navigation]
    var body: some View {
        Group {
            let author = notification.author
            HStack {
                Image(systemName: "heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .padding(5)
                    .clipped()
                    .foregroundColor(.pink)
                AvatarView(url: author.avatar, size: 40)
                HStack(spacing: 3) {
                    Button {
                        path.append(.profile(author.did))
                    } label: {
                        Text("@\(author.handle)")
                            .foregroundColor(.primary)
                            .underline(underline)
                            .hoverHand {
                                underline = $0
                            }
                            .tooltip {
                                ProfilePreview(did: author.did, path: $path)
                            }
                    }.buttonStyle(.plain)

                    Text("liked your post")
                        .opacity(0.8)

                    Text(
                        notification.indexedAt
                    )
                    .font(.body)
                    .foregroundColor(.secondary)
                    .help(notification.indexedAt)
                }
            }
        }
    }
}

struct NotificationsView: View {
    @State var notifications: appbskytypes.NotificationListNotifications_Output?
    @State private var postMap = [String: appbskytypes.FeedDefs_PostView]()
    @Binding var path: [Navigation]
    func getNotifications(cursor: String? = nil) async {
        var postMap = [String: appbskytypes.FeedDefs_PostView]()
        do {
            let notifications = try await appbskytypes.NotificationListNotifications(client: XRPCClient.shared, cursor: cursor, limit: 30, seenAt: nil)
            if cursor != nil {
                self.notifications = appbskytypes.NotificationListNotifications_Output(
                    cursor: notifications.cursor,
                    notifications: self.notifications!.notifications + notifications.notifications
                )
            } else {
                self.notifications = notifications
            }
            let uris = notifications.notifications.compactMap {
                if $0.uri.contains("app.bsky.feed.post") {
                    return $0.uri
                }
                return nil
            }
            let posts = try await appbskytypes.FeedGetPosts(client: XRPCClient.shared, uris: uris)
            for post in posts.posts {
                postMap[post.uri] = post
            }
            self.postMap = postMap
        } catch {}
    }

    var body: some View {
        List {
            Group {
                if let notifications {
                    ForEach(notifications.notifications) { notification in
                        Group {
                            switch notification.reason {
                            case "follow":
                                NotificationsViewFollow(notification: notification, path: $path)
                                    .padding(.bottom, 5)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                            case "repost":
                                NotificationsViewRepost(notification: notification, path: $path)
                                    .padding(.bottom, 5)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                            case "like":
                                NotificationsViewLike(notification: notification, path: $path)
                                    .padding(.bottom, 5)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                            default:
                                EmptyView()
                            }
                            if let post: appbskytypes.FeedDefs_PostView = postMap[notification.uri] {
                                PostView(post: post, path: $path)
                                    .padding(.horizontal)
                                    .padding(.top, notification.cid == notifications.notifications.first?.cid ? 5 : 0)
                                PostFooterView(post: post, path: $path)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                            }
                        }
                        .background {
                            if !notification.isRead {
                                Color.blue
                                    .opacity(0.5)
                            }
                        }
                        .onAppear {
                            Task {
                                if let cursor = notifications.cursor, notification.cid == notifications.notifications.last?.cid {
                                    await getNotifications(cursor: cursor)
                                }
                            }
                        }
                        Divider()
                            .padding(.bottom, 5)
                    }
                }
            }
            .listRowInsets(.init())
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 1)
        .scrollContentBackground(.hidden)
        .task {
            await getNotifications()
            PushNotificatios.shared.markasRead()
        }
    }
}
