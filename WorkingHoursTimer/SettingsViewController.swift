//
//  SettingsViewController.swift
//  WorkingHoursTimer
//
//  Created by yayoi on 2020/03/14.
//  Copyright © 2020 Y.Grace. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    var settings: Settings!
    
    enum Section: Int, CaseIterable {
        case hour
    }
    
    enum HourRow: Int, CaseIterable {
        case businessHour
        case breakTime
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settings = Settings.currentSettings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let theSection = Section(rawValue: section) else { fatalError() }
        switch theSection {
        case .hour:
            return HourRow.allCases.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        switch section {
        case .hour:
            guard let row = HourRow(rawValue: indexPath.row) else { fatalError() }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HourCell", for: indexPath) as? SettingsHourCell else { fatalError() }
            cell.settingsViewController = self
            switch row {
            case .businessHour:
                cell.hourType = .businessHour
            case .breakTime:
                cell.hourType = .breakTime
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let theSection = Section(rawValue: section) else { fatalError() }
        switch theSection {
        case .hour:
            return "時間の設定"
        }
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
