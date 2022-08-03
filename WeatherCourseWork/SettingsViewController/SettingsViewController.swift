//
//  SettingsViewController.swift
//  WeatherCourseWork
//
//  Created by Александр Шелихов on 02.08.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var optionsStack: UIStackView!
    
    var presenter: SettingsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func addOption<T: SettingsManagerOption>(_ option: T) {
        let vc = OptionViewController(nibName: "OptionViewController", bundle: nil)
        addChild(vc)
        optionsStack.addArrangedSubview(vc.view)
        vc.didMove(toParent: self)
        vc.configure(option)
    }
    
    @IBAction func setSettingsButtonPressed(_ sender: Any) {
        presenter?.setSettingsButtonPressed()
    }
}
