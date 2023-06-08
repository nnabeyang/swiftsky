//
//  FollowersView.swift
//  swiftsky
//

import SwiftUI

private struct FollowersRowView: View {
  @State var user: ActorDefsProfileViewBasic
  @State var usernamehover: Bool = false
  @State var followingdisabled: Bool = false
  @Binding var path: [Navigation]
  func follow() {
    followingdisabled = true
    Task {
      do {
        let result = try await followUser(
          did: user.did)
        self.user.viewer?.following = result.uri
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
        let result = try await repoDeleteRecord(
          uri: user.viewer!.following!, collection: "app.bsky.graph.follow")
        if result {
          self.user.viewer!.following = nil
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
            .hoverHand {usernamehover = $0}
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
      if user.did != Client.shared.did {
        let following = user.viewer?.following != nil
        Button {
          following ? unfollow() : follow()
        } label: {
          Group {
            if !following {
              Text("\(Image(systemName: "plus")) Follow")
            }
            else {
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
struct FollowersView: View {
  let handle: String
  @State var followers: graphGetFollowersOutput? = nil
  @Binding var path: [Navigation]
  func getFollowers() async {
    do {
      self.followers = try await graphGetFollowers(actor: handle)
    } catch {
      
    }
  }
  func getMoreFollowers(cursor: String) async {
    do {
      let result = try await graphGetFollowers(actor: handle, cursor: cursor)
      self.followers!.cursor = result.cursor
      self.followers!.followers.append(contentsOf: result.followers)
    } catch {
      
    }
  }
  var body: some View {
    List {
      if let followers {
        ForEach(followers.followers) { user in
          FollowersRowView(user: user, path: $path)
            .padding(5)
            .task {
              if user == followers.followers.last {
                if let cursor = followers.cursor {
                  await getMoreFollowers(cursor: cursor)
                }
              }
            }
          Divider()
        }
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        if followers.cursor != nil {
          ProgressView()
            .frame(maxWidth: .infinity, alignment: .center)
        }
  
      }
    }
    .environment(\.defaultMinListRowHeight, 1)
    .scrollContentBackground(.hidden)
    .listStyle(.plain)
    .task {
      await getFollowers()
    }
  }
}
