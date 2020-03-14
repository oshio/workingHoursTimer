//
//  ViewController.swift
//  WorkingHoursTimer
//
//  Created by yayoi on 2020/03/14.
//  Copyright © 2020 Y.Grace. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var fixedTimeLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    
    var startTime: Date!
    var fixedTime: Date!
    var countDownTimer: Timer!
    var settings: Settings!
    
    private var timeFormatter: DateFormatter {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        return timeFormatter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.settings = Settings.currentSettings()
        self.countDownTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(settingUpdated), name: .settingsUpdated, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.settingUpdated()
    }
    
    @objc private func settingUpdated() {
        self.settings = Settings.currentSettings()
        self.startTimeLabel.text = self.settings.startTimeString
        self.startTime = Date()
        
        self.startTime = TimeUtility.todayWithTheTime(fromTimeString: self.settings.startTimeString)
        self.fixedTime = startTime.addingTimeInterval(60 * TimeInterval(self.settings.businessHourInMinute + self.settings.breakTimeInMinute))
        self.fixedTimeLabel.text = self.timeFormatter.string(from: fixedTime)
        self.updateTime()
    }
    
    @objc private func updateTime() {
        let remainingTimeInMinute = abs(Date().timeIntervalSince(self.fixedTime)) / 60
        self.remainingTimeLabel.text = TimeUtility.timeString(from: Int(remainingTimeInMinute))
    }
    
    @IBAction func settingsTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? UINavigationController else { fatalError() }
        self.present(viewController, animated: true, completion: nil)
    }

    @IBAction func setStartTimeTapped(_ sender: UIButton) {
        let viewController = SettingsTimePickerViewController.instantiate(settings: Settings.currentSettings())
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

