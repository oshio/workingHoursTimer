//
//  TimeUtility.swift
//  WorkingHoursTimer
//
//  Created by yayoi on 2020/03/14.
//  Copyright © 2020 Y.Grace. All rights reserved.
//

import UIKit

class TimeUtility: NSObject {
    class func timeString(from inMinute: Int) -> String {
        let hour = inMinute / 60
        var hourString = "\(hour)"
        let minute = inMinute - hour * 60
        var minuteString = "\(minute)"
        
        if hour < 10 {
            hourString = "0" + hourString
        }
        if minute < 10 {
            minuteString = "0" + minuteString
        }
        
        return hourString + ":" + minuteString
    }
    
    class func minutes(from string: String) -> Int {
        let hour = Int(string.split(separator: ":")[0]) ?? 0
        let minute = Int(string.split(separator: ":")[1]) ?? 0
        return hour * 60 + minute
    }
    
    class func todayWithTheTime(fromTimeString string: String) -> Date {
        let hour = Int(string.split(separator: ":")[0]) ?? 0
        let minute = Int(string.split(separator: ":")[1]) ?? 0
        guard let todayWithTheTime =  Calendar(identifier: .gregorian).date(bySettingHour: hour, minute: minute, second: 0, of: Date()) else { fatalError() }
        return todayWithTheTime
    }
}
