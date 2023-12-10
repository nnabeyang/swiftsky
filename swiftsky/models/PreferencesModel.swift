//
//  PreferencesModel.swift
//  swiftsky
//

import Foundation
import SwiftUI

class CustomFeedModel: Identifiable, Equatable, Hashable {
    static func == (lhs: CustomFeedModel, rhs: CustomFeedModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var id: String {
        uri
    }

    var data: appbskytypes.FeedDefs_GeneratorView
    var uri: String {
        data.uri
    }

    var avatar: String? {
        data.avatar
    }

    var displayName: String {
        data.displayName
    }

    init(data: appbskytypes.FeedDefs_GeneratorView) {
        self.data = data
    }
}

class SavedFeedsModel {
    static var shared = SavedFeedsModel()
    var feedModelCache = NSCache<NSString, CustomFeedModel>()
    func updateCache() async throws {
        let newFeedModels = NSCache<NSString, CustomFeedModel>()
        var neededFeedUris: [String] = []
        for feedUri in PreferencesModel.shared.savedFeeds {
            if !newFeedModels.doesContain(feedUri) {
                neededFeedUris.append(feedUri)
            }
        }
        for i in stride(from: 0, to: neededFeedUris.count, by: 25) {
            let res = try await appbskytypes.FeedGetFeedGenerators(client: XRPCClient.shared, feeds: Array(neededFeedUris[i ..< min(i + 25, neededFeedUris.count)]))
            for feedInfo in res.feeds {
                newFeedModels.setObject(CustomFeedModel(data: feedInfo), forKey: feedInfo.uri as NSString)
            }
        }
        feedModelCache = newFeedModels
    }

    func get(uri: String) -> CustomFeedModel? {
        feedModelCache.object(forKey: uri as NSString)
    }

    var pinned: [CustomFeedModel] {
        PreferencesModel.shared.pinnedFeeds.compactMap { uri in
            feedModelCache.object(forKey: uri as NSString)
        }
    }
}

class PreferencesModel: ObservableObject {
    static var shared = PreferencesModel()
    @Published var savedFeeds: [String] = []
    @Published var pinnedFeeds: [String] = []
    func update(cb: @escaping ([appbskytypes.ActorDefs_Preferences_Elem]) -> ([appbskytypes.ActorDefs_Preferences_Elem]?)) async throws {
        let res = try await appbskytypes.ActorGetPreferences(client: XRPCClient.shared)
        if let newPrefs = cb(res.preferences) {
            let _ = try await appbskytypes.ActorPutPreferences(client: XRPCClient.shared, input: .init(preferences: newPrefs))
        }
    }

    func sync() async throws {
        let res = try await appbskytypes.ActorGetPreferences(client: XRPCClient.shared).preferences
        for pref in res {
            switch pref {
            case let .actorDefsSavedFeedsPref(feeds):
                DispatchQueue.main.async {
                    self.savedFeeds = feeds.saved
                    self.pinnedFeeds = feeds.pinned
                }
            default:
                break
            }
        }
    }

    func setSavedFeeds(saved: [String], pinned: [String]) async {
        let oldSaved = savedFeeds
        let oldPinned = pinnedFeeds
        DispatchQueue.main.async {
            self.savedFeeds = saved
            self.pinnedFeeds = pinned
        }
        do {
            try await update { prefs in
                let feedsPref = prefs.first(where: { if case appbskytypes.ActorDefs_Preferences_Elem.actorDefsSavedFeedsPref = $0 {
                    return true
                }
                return false
                })
                var prefsfiltered = prefs.filter {
                    if case appbskytypes.ActorDefs_Preferences_Elem.actorDefsSavedFeedsPref = $0 {
                        return false
                    }
                    return true
                }
                if case .actorDefsSavedFeedsPref = feedsPref {
                    let feeds = appbskytypes.ActorDefs_SavedFeedsPref(pinned: pinned, saved: saved)
                    prefsfiltered.append(.actorDefsSavedFeedsPref(feeds))
                }

                return prefsfiltered
            }
        } catch {
            DispatchQueue.main.async {
                self.savedFeeds = oldSaved
                self.pinnedFeeds = oldPinned
            }
            print(error)
        }
    }

    func deletefeed(uri: String) async {
        var pinned = pinnedFeeds
        var saved = savedFeeds
        if let pindex = pinned.firstIndex(where: { $0 == uri }) {
            pinned.remove(at: pindex)
        }
        if let sindex = saved.firstIndex(where: { $0 == uri }) {
            saved.remove(at: sindex)
        }
        await setSavedFeeds(saved: saved, pinned: pinned)
    }

    func unpinfeed(uri: String) async {
        var pinned = pinnedFeeds
        if let pindex = pinned.firstIndex(where: { $0 == uri }) {
            pinned.remove(at: pindex)
        }
        await setSavedFeeds(saved: savedFeeds, pinned: pinned)
    }

    func addsavedfeed(uri: String) async {
        await setSavedFeeds(saved: savedFeeds + [uri], pinned: pinnedFeeds)
    }

    func addpinnedfeed(uri: String) async {
        await setSavedFeeds(saved: savedFeeds, pinned: pinnedFeeds + [uri])
    }
}
