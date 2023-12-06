//
//  PushNotifications.swift
//  swiftsky
//

import Foundation

class PushNotificatios: ObservableObject {
    static let shared = PushNotificatios()
    var unreadcount: Int = 0
    private var backgroundtask: Task<Void, Never>?
    public func resumeRefreshTask() {
        backgroundtask?.cancel()
        backgroundtask = Task {
            while !Task.isCancelled {
                if Auth.shared.needAuthorization {
                    break
                }
                if let notifications = try? await NotificationListNotifications().notifications {
                    let unreadnotifications = notifications.filter {
                        !$0.isRead
                    }
                    self.setunreadCount(unreadnotifications.count)
                }
                try? await Task.sleep(nanoseconds: 30 * 1_000_000_000)
            }
        }
    }

    public func cancelRefreshTask() {
        backgroundtask?.cancel()
    }

    public func setunreadCount(_ value: Int) {
        if unreadcount != value {
            unreadcount = value
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }

    public func markasRead() {
        setunreadCount(0)
        Task {
            try? await notificationUpdateSeen()
        }
    }

    init() {
        if !Auth.shared.needAuthorization {
            resumeRefreshTask()
        }
    }
}
