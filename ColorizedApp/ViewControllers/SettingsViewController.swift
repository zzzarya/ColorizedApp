//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Антон Заричный on 05.08.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var redValue: UILabel!
    @IBOutlet var greenValue: UILabel!
    @IBOutlet var blueValue: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    var viewColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decomposeRGB()
        
        mainView.layer.cornerRadius = 10
    }

    @IBAction func redSliderAction() {
        redValue.text = String(format: "%.2f", redSlider.value)
        
        setupColorMainView()
    }
    
    @IBAction func greenSliderAction() {
        greenValue.text = String(format: "%.2f", greenSlider.value)

        setupColorMainView()
    }
    
    @IBAction func blueSliderAction() {
        blueValue.text = String(format: "%.2f", blueSlider.value)
       
        setupColorMainView()
    }
    
    private func setupColorMainView() {
        let redComponent = CGFloat(redSlider.value)
        let greenComponent = CGFloat(greenSlider.value)
        let blueComponent = CGFloat(blueSlider.value)
        mainView.backgroundColor = UIColor(red: redComponent,
                                           green: greenComponent,
                                           blue: blueComponent,
                                           alpha: 1)
    }
    
    private func decomposeRGB() {
        mainView.backgroundColor = viewColor
        
        guard let components = viewColor.cgColor.components else { return }
        
        redSlider.value = Float(components[0])
        greenSlider.value = Float(components[1])
        blueSlider.value = Float(components[2])
        
        redValue.text = String(format: "%.2f", redSlider.value)
        greenValue.text = String(format: "%.2f", greenSlider.value)
        blueValue.text = String(format: "%.2f", blueSlider.value)
    }
    
}


