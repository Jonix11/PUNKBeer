//
//  FilterViewController.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 26/2/21.
//

import UIKit

class FilterViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var abvGreaterTextField: UITextField!
    @IBOutlet weak var abvLessTextField: UITextField!
    @IBOutlet weak var brewedAfterTextField: UITextField!
    @IBOutlet weak var brewedBeforeTextField: UITextField!
    
    //MARK: - Actions
    @IBAction func removeFiltersButtonTapped(_ sender: Any) {
    }
    
    //MARK: - Properties
    let filters: [(String, String)]?
    let abvGreaterPickerView = UIPickerView()
    let abvLessPickerView = UIPickerView()
    let brewedAfterPickerView = UIPickerView()
    let brewedBeforePickerView = UIPickerView()
    var abvGreaterData: [String] = ["Greater than"]
    var abvLessData: [String] = ["Less than"]
    var monthData: [String] = ["Month"]
    var yearData: [String] = ["Year"]
    
    //MARK: - Initialization
    init(withFilters filters: [(String, String)]?) {
        self.filters = filters
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        for item in 1...60 {
            abvGreaterData.append("\(item)")
            abvLessData.append("\(item)")
        }
        
        for month in 1...12 {
            monthData.append("\(month)")
        }
        
        for year in 1990...2021 {
            yearData.append("\(year)")
        }
        configurePickers()
    }
    
    func configurePickers () {
        abvGreaterPickerView.tag = 1
        abvLessPickerView.tag = 2
        brewedAfterPickerView.tag = 3
        brewedBeforePickerView.tag = 4
        [abvGreaterPickerView, abvLessPickerView, brewedAfterPickerView, brewedBeforePickerView].forEach {
            $0.delegate = self
            $0.dataSource = self
        }
        
        abvGreaterTextField.inputView = abvGreaterPickerView
        abvLessTextField.inputView = abvLessPickerView
        brewedAfterTextField.inputView = brewedAfterPickerView
        brewedBeforeTextField.inputView = brewedBeforePickerView
        abvGreaterTextField.text = abvGreaterData[0]
        abvLessTextField.text = abvLessData[0]
        brewedBeforeTextField.text = "Brewed before"
        brewedAfterTextField.text = "Brewed after"
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
        toolBar.setItems([doneButton], animated: true)
        
        [abvGreaterTextField, abvLessTextField, brewedAfterTextField, brewedBeforeTextField].forEach {
            $0?.inputAccessoryView = toolBar
        }
        
    }
    
    @objc func done() {
        
    }

}

extension FilterViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return abvGreaterData[row]
        case 2:
            return abvLessData[row]
        case 3, 4:
            if component == 0 {
                return monthData[row]
            } else {
                return yearData[row]
            }
        default:
            return nil
        }
    }
    
}

extension FilterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 1 || pickerView.tag == 2 {
            return 1
        } else {
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return abvGreaterData.count
        case 2:
            return abvLessData.count
        case 3, 4:
            if component == 0 {
                return monthData.count
            } else {
                return yearData.count
            }
        default:
            return 0
        }
    }
}
