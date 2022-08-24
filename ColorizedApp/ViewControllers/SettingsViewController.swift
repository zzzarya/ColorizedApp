//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Антон Заричный on 05.08.2022.
//

import UIKit

final class SettingsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var redValue: UILabel!
    @IBOutlet var greenValue: UILabel!
    @IBOutlet var blueValue: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redValueTF: UITextField! {
        didSet { redValueTF?.addDoneToolbar() }
    }
    @IBOutlet var greenValueTF: UITextField! {
        didSet { greenValueTF?.addDoneToolbar() }
    }
    @IBOutlet var blueValueTF: UITextField! {
        didSet { blueValueTF?.addDoneToolbar() }
    }
    // MARK: - Properties
    var viewColor: UIColor!
    
    var delegate: SettingsViewControllerDelegate!
    // MARK: - Override functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.endEditing(true)
        
        redValueTF.delegate = self
        greenValueTF.delegate = self
        blueValueTF.delegate = self
        
        decomposeRGB()
        
        mainView.layer.cornerRadius = 10
    }
    // MARK: - IBActions
    @IBAction func redSliderAction() {
        redValue.text = String(format: "%.2f", redSlider.value)
        redValueTF.text = String(format: "%.2f", redSlider.value)
        
        setupColorMainView()
    }
    
    @IBAction func greenSliderAction() {
        greenValue.text = String(format: "%.2f", greenSlider.value)
        greenValueTF.text = String(format: "%.2f", greenSlider.value)

        setupColorMainView()
    }
    
    @IBAction func blueSliderAction() {
        blueValue.text = String(format: "%.2f", blueSlider.value)
        blueValueTF.text = String(format: "%.2f", blueSlider.value)
       
        setupColorMainView()
    }
    
    @IBAction func donePressed() {
        delegate.setNewViewColor(from: mainView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    // MARK: - Private functions
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
        
        redValueTF.text = String(format: "%.2f", redSlider.value)
        greenValueTF.text = String(format: "%.2f", greenSlider.value)
        blueValueTF.text = String(format: "%.2f", blueSlider.value)
        
    }
}
// MARK: - Extensions
extension SettingsViewController {
    private func showAlert(with title: String, and massage: String, _ textField: UITextField) {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField.text = ""}
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension SettingsViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let value = Float(textField.text ?? ""), value <= 1 {
            switch textField {
            case redValueTF:
                redValue.text = redValueTF.text
                redSlider.value = value
            case greenValueTF:
                greenValue.text = greenValueTF.text
                greenSlider.value = value
            default:
                blueValue.text = blueValueTF.text
                blueSlider.value = value
            }
        } else {
            showAlert(with: "Wrong format", and: "Use range from 0.00 to 1.00", textField)
        }
        
        setupColorMainView()
    }
}

// Честно нагуглил
extension UITextField {
    func addDoneToolbar(onDone: (target: Any, action: Selector)? = nil) {
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }

    @objc func doneButtonTapped() { self.resignFirstResponder() }
}



