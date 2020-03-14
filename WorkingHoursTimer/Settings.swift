//
//  Settings.swift
//  WorkingHoursTimer
//
//  Created by yayoi on 2020/03/14.
//  Copyright © 2020 Y.Grace. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let settingsUpdated = Notification.Name("SettingsUpdatedNotification")
}

class Settings {
    static var startTimeKey = "StartTime"
    static var businessHourInMinuteKey = "BusinessHourInMinute"
    static var breakTimeInMinuteKey = "BreakTimeInMinute"
    
    var startTimeString: String = "10:30"
    var businessHourInMinute: Int = 60 * 8
    var breakTimeInMinute: Int = 60

    func saveSettings() {
        UserDefaults.standard.set(self.startTimeString, forKey: Settings.startTimeKey)
        UserDefaults.standard.set(self.businessHourInMinute, forKey: Settings.businessHourInMinuteKey)
        UserDefaults.standard.set(self.breakTimeInMinute, forKey: Settings.breakTimeInMinuteKey)
        NotificationCenter.default.post(name: .settingsUpdated, object: self)
    }
    
    class func currentSettings() -> Settings {
        let settings = Settings()
        if let startTime = UserDefaults.standard.string(forKey: Settings.startTimeKey) {
            settings.startTimeString = startTime
        }
        let businessHourInMinute = UserDefaults.standard.integer(forKey: Settings.businessHourInMinuteKey)
        let breakTimeInMinute = UserDefaults.standard.integer(forKey: Settings.breakTimeInMinuteKey)
        if  businessHourInMinute > 0 && breakTimeInMinute > 0 {
            settings.breakTimeInMinute = breakTimeInMinute
            settings.businessHourInMinute = businessHourInMinute
        }
        return settings
    }
}
