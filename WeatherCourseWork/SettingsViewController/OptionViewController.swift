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
    
    private var updateOptionClosure: ((Int) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.almostWhiteColor], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.almostBlackColor], for: .normal)
    }
    
    func configure<T: SettingsManagerOption>(settingsManagerOption: T, updateOptionClosure: @escaping (Int) -> ()) {
        titleLabel.text = T.title
        segmentedControl.removeAllSegments()
        for option in T.allCases.reversed() {
            segmentedControl.insertSegment(withTitle: option.title, at: 0, animated: false)
        }
        if let selectedIndex = T.allCases.firstIndex(where: { test in test == settingsManagerOption }), let selectedIndex = selectedIndex as? Int {
            segmentedControl.selectedSegmentIndex = selectedIndex
        }
        self.updateOptionClosure = updateOptionClosure
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        updateOptionClosure?(segmentedControl.selectedSegmentIndex)
    }
    
}
