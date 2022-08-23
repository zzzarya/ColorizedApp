//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Антон Заричный on 23.08.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewViewColor(from mainViewColor: UIColor)
}

class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.viewColor = view.backgroundColor
        settingsVC.delegate = self
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setNewViewColor(from mainViewColor: UIColor) {
        view.backgroundColor = mainViewColor
    }
}
