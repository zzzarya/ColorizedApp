//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Антон Заричный on 05.08.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var redValue: UILabel!
    @IBOutlet var greenValue: UILabel!
    @IBOutlet var blueValue: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 10
        setupColorMainView()
    }

    @IBAction func redSliderAction() {
        redValue.text = String(round(redSlider.value * 100) / 100)
        
        setupColorMainView()
    }
    
    @IBAction func greenSliderAction() {
        greenValue.text = String(round(greenSlider.value * 100) / 100)

        setupColorMainView()
    }
    
    @IBAction func blueSliderAction() {
        blueValue.text = String(round(blueSlider.value * 100) / 100)
       
        setupColorMainView()
    }
    
    private func setupColorMainView() {
        let redComponent = CGFloat(redSlider.value)
        let greenComponent = CGFloat(greenSlider.value)
        let blueComponent = CGFloat(blueSlider.value)
        mainView.backgroundColor = UIColor(red: redComponent, green: greenComponent, blue: blueComponent, alpha: 1)
    }
    
}



