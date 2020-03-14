//
//  SettingsTimePickerViewController.swift
//  WorkingHoursTimer
//
//  Created by yayoi on 2020/03/14.
//  Copyright © 2020 Y.Grace. All rights reserved.
//

import UIKit

class SettingsTimePickerViewController: UIViewController {

    enum TimeType {
        case startTime
        case businessHour
        case breakTime
    }
    
    @IBOutlet weak var timePicker: UIDatePicker!
    private var settings: Settings!
    var timeType: TimeType = .startTime
    private var timeFormatter: DateFormatter {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        return timeFormatter
    }

    class func instantiate(settings: Settings) -> SettingsTimePickerViewController {
        let storyboard = UIStoryboard(name: "TimePicker", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? SettingsTimePickerViewController else { fatalError() }
        viewController.settings = settings
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch self.timeType {
        case .startTime:
            self.title = "今日の出勤時刻"
            self.timePicker.date = self.timeFormatter.date(from: settings.startTimeString) ?? Date()
        case .businessHour:
            self.title = "勤務時間を設定"
            guard let businessHour = self.timeFormatter.date(from: TimeUtility.timeString(from: settings.businessHourInMinute)) else { fatalError() }
            self.timePicker.date = businessHour
        case .breakTime:
            self.title = "休憩時間を設定"
            guard let breakTime = self.timeFormatter.date(from: TimeUtility.timeString(from: settings.breakTimeInMinute)) else {  fatalError() }
            self.timePicker.date = breakTime
        }
    }

    @IBAction func timePickerValueChanged(_ sender: UIDatePicker) {
        let timeString = self.timeFormatter.string(from: sender.date)
        switch self.timeType {
        case .startTime:
            self.settings.startTimeString = timeString
        case .businessHour:
            self.settings.businessHourInMinute = TimeUtility.minutes(from: timeString)
        case .breakTime:
            self.settings.breakTimeInMinute = TimeUtility.minutes(from: timeString)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.settings.saveSettings()
    }
}
