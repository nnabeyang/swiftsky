//
//  HomeView.swift
//  swiftsky
//

import SwiftUI

struct HomeView: View {
    @State var timeline: appbskytypes.FeedGetTimeline_Output = .init(cursor: nil, feed: [])
    @State var loading = false
    @Binding var path: [Navigation]
    func loadContent() async {
        loading = true
        do {
            timeline = try await appbskytypes.FeedGetTimeline(algorithm: "reverse-chronological", cursor: nil, limit: 30)
        } catch {
            print(error)
        }
        loading = false
    }

    var body: some View {
        List {
            Group {
                let filteredfeed = timeline.feed.filter {
                    let reply = $0.reply?.parent.post
                    let author = reply?.author
                    let following = author?.viewer?.following
                    let repost = $0.reason
                    return (reply == nil || following != nil || author?.did == XRPCClient.shared.auth.did || ($0.post.likeCount ?? 0) >= 5) || repost != nil
                }
                if loading, !filteredfeed.isEmpty {
                    ProgressView().frame(maxWidth: .infinity, alignment: .center)
                }
                ForEach(filteredfeed) { post in
                    PostView(
                        post: post.post, reply: post.reply?.parent.author?.handle, repost: post.reason?.repost,
                        path: $path
                    )
                    .padding([.top, .horizontal])
                    .contentShape(Rectangle())
                    .onTapGesture {
                        path.append(.thread(post.post.uri))
                    }
                    .task {
                        if post === filteredfeed.last {
                            if let cursor = timeline.cursor {
                                do {
                                    let result = try await appbskytypes.FeedGetTimeline(algorithm: "reverse-chronological", cursor: cursor, limit: 30)
                                    timeline = .init(cursor: result.cursor, feed: timeline.feed + result.feed)
                                } catch {
                                    print(error)
                                }
                            }
                        }
                    }
                    PostFooterView(post: post.post, path: $path)
                    Divider()
                }
                if timeline.cursor != nil {
                    ProgressView().frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
        .environment(\.defaultMinListRowHeight, 1)
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    Task {
                        await loadContent()
                    }
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
                .disabled(loading)
            }
        }
        .task {
            await loadContent()
        }
    }
}
