//
//  SettingsBusinessHourCell.swift
//  WorkingHoursTimer
//
//  Created by yayoi on 2020/03/14.
//  Copyright © 2020 Y.Grace. All rights reserved.
//

import UIKit

class SettingsHourCell: UITableViewCell {

    enum HourType {
        case businessHour
        case breakTime
    }
    
    var hourType: HourType = .businessHour
    var settingsViewController: SettingsViewController!
    
    @IBOutlet weak var hourTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let settings = Settings.currentSettings()
        switch self.hourType {
        case .businessHour:
            self.hourTitleLabel.text = "勤務時間"
            self.timeLabel.text = TimeUtility.timeString(from: settings.businessHourInMinute)
        case .breakTime:
            self.hourTitleLabel.text = "休憩時間"
            self.timeLabel.text = TimeUtility.timeString(from: settings.breakTimeInMinute)
        }
    }

    @IBAction func changeTapped(_ sender: Any) {
        let viewController = SettingsTimePickerViewController.instantiate(settings: self.settingsViewController.settings)
        switch self.hourType {
        case .businessHour:
            viewController.timeType = .businessHour
        case .breakTime:
            viewController.timeType = .breakTime
        }
        self.settingsViewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
