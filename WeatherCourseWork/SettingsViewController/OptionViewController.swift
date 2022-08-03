//
//  OptionViewController.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 03.08.2022.
//

import UIKit

class OptionViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    func configure<T: SettingsManagerOption>(_ settingsManagerOption: T) {
        titleLabel.text = T.title
        segmentedControl.removeAllSegments()
        for option in T.allCases.reversed() {
            segmentedControl.insertSegment(withTitle: option.title, at: 0, animated: false)
        }
        if let selectedIndex = T.allCases.firstIndex(where: { test in test == settingsManagerOption }), let selectedIndex = selectedIndex as? Int {
            segmentedControl.selectedSegmentIndex = selectedIndex
        }
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        print("now select:", segmentedControl.selectedSegmentIndex)
    }
    
}
