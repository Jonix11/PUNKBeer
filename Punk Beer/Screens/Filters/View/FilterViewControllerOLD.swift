//
//  FilterViewController.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 26/2/21.
//

import UIKit

class FilterViewControllerOLD: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var abvFilterPicker: UIPickerView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textField2: UITextField!
    
    //MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        abvFilterPicker.dataSource = self
        abvFilterPicker.delegate = self
        let pickerView = UIPickerView()
        pickerView.tag = 1
        pickerView.delegate = self
        textField.inputView = pickerView
        dismissPickerView()
        print(pickerView.tag, abvFilterPicker.tag)
    }
    
    func dismissPickerView() {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
       let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
       textField.inputAccessoryView = toolBar
    }
    @objc func action() {
          view.endEditing(true)
    }
    
    //MARK: - Actions
    
    @IBAction func removeFilterButtonTapped(_ sender: Any) {
    }
    
}

extension FilterViewControllerOLD: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let title = ["Greater than", "Less than"]
        if row == 0 {
            return title[component]
        } else {
            let selectedRow = pickerView.selectedRow(inComponent: 0)
            if component == 1 && selectedRow != 0 {
                return "\(row + selectedRow)%"
            } else {
                return "\(row)%"
            }
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 { pickerView.reloadAllComponents()}
        
    }
}

extension FilterViewControllerOLD: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 61
        } else {
            let selectedRow = pickerView.selectedRow(inComponent: 0)
            if selectedRow != 0 {
                return 61 - selectedRow
            } else {
                return 61
            }
            
        }
        
    }
    
}
