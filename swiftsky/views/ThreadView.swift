//
//  ThreadView.swift
//  swiftsky
//

import SwiftUI

struct ReplyView: View {
    @Binding var isPresented: Bool
    @State var viewpost: FeedPostView
    @State var reply = ""
    var body: some View {
        VStack {
            HStack() {
                Button("Cancel") {
                    isPresented = false
                }
                .buttonStyle(.plain)
                .padding([.leading, .top], 20)
                .foregroundColor(.accentColor)
                Spacer()
                Button("Reply") { }
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                .disabled(reply.count > 256)
                .padding([.trailing, .top], 20)
            }
            Divider().padding(.vertical, 5)
            HStack(alignment: .top, spacing: 12) {
                if let avatar = viewpost.author.avatar {
                    AvatarView(url: URL(string: avatar)!, size: 50)
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .foregroundColor(.accentColor)
                        .frame(width: 50, height: 50)
                        .cornerRadius(20)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(viewpost.author.displayName ?? viewpost.author.handle)
                        .fontWeight(.semibold)
                    Text(viewpost.record.text)
                }
                Spacer()
            }
            .padding(.leading, 20)
            Divider()
                .padding(.vertical, 5)
            HStack(alignment: .top) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .foregroundColor(.accentColor)
                    .frame(width: 50, height: 50)
                    .cornerRadius(20)
                
                TextEditor(text: $reply)
                    .scrollContentBackground(.hidden)
                    .font(.system(size: 20))
                
                Spacer()
            }
            .padding([.leading], 20)
            Divider()
                .padding(.vertical, 5)
            HStack {
                Spacer()
                let replycount = 256 - reply.count
                Text("\(replycount)")
                    .padding(.trailing, 20)
                    .foregroundColor(replycount < 0 ? .red : .primary)
                    
            }
            Spacer()
        }
    }
}
struct ThreadView: View {
    @State var viewpost: FeedPostView
    @State var reply: FeedFeedViewPostReplyRef?
    
    @State var timeline: FeedGetTimelineOutput = FeedGetTimelineOutput()
    @State var replies: [FeedGetPostThreadThreadViewPost]?
    @State var compose: Bool = false
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if let reply = reply {
                    NavigationLink(destination: ThreadView(viewpost: reply.parent)) {
                        PostView(post: reply.parent)
                            .padding([.top,.horizontal])
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    PostFooterView(post: reply.parent)
                        .padding(.leading, 67.0)
                }
                Divider()
                
                PostView(post: viewpost, reply: reply)
                    .padding([.top, .horizontal])
                PostFooterView(post: viewpost)
                    .padding(.leading, 67.0)
                Divider()
                HStack() {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .foregroundColor(.accentColor)
                        .frame(width: 40, height: 40)
                        .padding(.leading)
                        .padding([.vertical, .trailing], 5)
                    
                    Text("Reply to @\(viewpost.author.handle)")
                        .font(.system(size: 15))
                        .opacity(0.9)
                    Spacer()
                }.onHover { ishovered in
                    if ishovered {
                        NSCursor.pointingHand.push()
                    }
                    else {
                        NSCursor.pointingHand.pop()
                    }
                }.onTapGesture {
                    compose = true
                }
                .sheet(isPresented: $compose) {
                    ReplyView(isPresented: $compose, viewpost: viewpost)
                        .frame(minWidth: 600, maxWidth: 600, minHeight: 400, maxHeight: 800)
                }
                Divider()
                if let replies = replies {
                    ForEach(replies, id: \.self) { post in
                        NavigationLink(destination: ThreadView(viewpost: post.post)) {
                            HStack {
                                PostView(post: post.post)
                                    .padding([.top, .horizontal])
                                    .contentShape(Rectangle())
                                
                            }
                        }
                        .buttonStyle(.plain)
                        PostFooterView(post: post.post)
                            .padding(.leading, 67.0)
                        Divider()
                    }
                }
                
            }
        }
        .navigationTitle("\(viewpost.author.handle)'s post")
        .onAppear {
            getPostThread(uri: viewpost.uri) { result in
                if let result = result {
                    if let thread = result.thread {
                        self.replies = thread.replies
                    }
                }
            }
        }
    }
}

