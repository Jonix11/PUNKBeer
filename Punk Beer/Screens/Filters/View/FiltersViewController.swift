//
//  FiltersViewController.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 27/2/21.
//

import UIKit

class FiltersViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var abvPickerView: UIPickerView!
    @IBOutlet weak var brewedAfterPickerView: UIPickerView!
    @IBOutlet weak var brewedBeforePickerView: UIPickerView!
    
    //MARK: - Properties
    var filters: [String: String]
    weak var delegate: FiltersViewControllerDelegate?
    let ABV_PICKER_NUMBERS_ROWS = 61
    var yearsArray: [String] = ["Year"]
    var monthArray: [String] = ["Month", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]

    //MARK: - Initialization
    init(filters: [String: String]) {
        self.filters = filters
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        [abvPickerView, brewedAfterPickerView, brewedBeforePickerView].forEach {
            $0?.delegate = self
            $0?.dataSource = self
        }
        for year in 2007...2016 {
            yearsArray.append("\(year)")
        }
        abvPickerView.tag = 0
        brewedAfterPickerView.tag = 1
        brewedBeforePickerView.tag = 2
        setupUI()
        syncFiltersWithView()
    }
    
    //MARK: - Actions
    @IBAction func removeFiltersButtonTapped(_ sender: Any) {
        abvPickerView.selectRow(0, inComponent: 0, animated: true)
        abvPickerView.selectRow(0, inComponent: 1, animated: true)
        brewedAfterPickerView.selectRow(0, inComponent: 0, animated: true)
        brewedAfterPickerView.selectRow(0, inComponent: 1, animated: true)
        brewedBeforePickerView.selectRow(0, inComponent: 0, animated: true)
        brewedBeforePickerView.selectRow(0, inComponent: 1, animated: true)
    }
    
    //MARK: - Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setupUI() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let applyButton = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(applyButtonTapped))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolBar.items = [cancelButton, flexible, applyButton]
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func applyButtonTapped() {
        let greaterSelected = abvPickerView.selectedRow(inComponent: 0)
        let lessSelected = abvPickerView.selectedRow(inComponent: 1)
        let brewedAfterSelected = brewedAfterPickerView.selectedRow(inComponent: 0)
        let brewedBeforeSelected = brewedBeforePickerView.selectedRow(inComponent: 0)
        
        if greaterSelected != 0 {
            filters.updateValue("\(greaterSelected)", forKey: PunkAPIConstants.GREATER_FILTER)
        } else {
            filters.removeValue(forKey: PunkAPIConstants.GREATER_FILTER)
        }
        
        if lessSelected != 0 {
            let value = greaterSelected + lessSelected
            filters.updateValue("\(value)", forKey: PunkAPIConstants.LESS_FILTER)
        } else {
            filters.removeValue(forKey: PunkAPIConstants.LESS_FILTER)
        }
        
        if brewedAfterSelected != 0 {
            let yearSelected = brewedAfterPickerView.selectedRow(inComponent: 1)
            let value = "\(monthArray[brewedAfterSelected])-\(yearsArray[yearSelected])"
            filters.updateValue(value, forKey: PunkAPIConstants.BREWED_AFTER_FILTER)
        } else {
            filters.removeValue(forKey: PunkAPIConstants.BREWED_AFTER_FILTER)
        }
        
        if brewedBeforeSelected != 0 {
            let yearSelected = brewedBeforePickerView.selectedRow(inComponent: 1)
            let value = "\(monthArray[brewedBeforeSelected])-\(yearsArray[yearSelected])"
            filters.updateValue(value, forKey: PunkAPIConstants.BREWED_BEFORE_FILTER)
        } else {
            filters.removeValue(forKey: PunkAPIConstants.BREWED_BEFORE_FILTER)
        }
        
        delegate?.filtersViewController(self, didApplyFilters: filters)
        self.dismiss(animated: true, completion: nil)
    }
    
    func syncFiltersWithView() {
        var greaterInt: Int = 0
        if let greater = filters[PunkAPIConstants.GREATER_FILTER] {
            if let greaterValue = Int(greater) {
                greaterInt = greaterValue
                abvPickerView.selectRow(greaterValue, inComponent: 0, animated: true)
            }
        }
        
        if let less = filters[PunkAPIConstants.LESS_FILTER] {
            if let lessValue = Int(less) {
                abvPickerView.selectRow(lessValue - greaterInt, inComponent: 1, animated: true)
            }
        }
        
        if let brewedAfter = filters[PunkAPIConstants.BREWED_AFTER_FILTER] {
            let componentsArray = brewedAfter.components(separatedBy: "-")
            if let monthInt = Int(componentsArray[0]) {
                brewedAfterPickerView.selectRow(monthInt, inComponent: 0, animated: true)
            }
            if let yearInt = yearsArray.firstIndex(of: componentsArray[1]) {
                brewedAfterPickerView.selectRow(yearInt, inComponent: 1, animated: true)
            }
        }
        
        if let brewedBefore = filters[PunkAPIConstants.BREWED_BEFORE_FILTER] {
            let componentsArray = brewedBefore.components(separatedBy: "-")
            if let monthInt = Int(componentsArray[0]) {
                brewedBeforePickerView.selectRow(monthInt, inComponent: 0, animated: true)
            }
            if let yearInt = yearsArray.firstIndex(of: componentsArray[1]) {
                brewedBeforePickerView.selectRow(yearInt, inComponent: 1, animated: true)
            }
        }
    }

}

extension FiltersViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            if component == 0 {
                return ABV_PICKER_NUMBERS_ROWS
            } else {
                let selectedRow = pickerView.selectedRow(inComponent: 0)
                if selectedRow != 0 {
                    return ABV_PICKER_NUMBERS_ROWS - selectedRow
                } else {
                    return ABV_PICKER_NUMBERS_ROWS
                }
                
            }
        } else {
            if component == 0 {
                return monthArray.count
            } else {
                return yearsArray.count
            }
        }
    }
    
    
}

extension FiltersViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
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
        } else {
            
            if component == 0 {
                return monthArray[row]
            } else {
                return yearsArray[row]
            }
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 && component == 0 {
            pickerView.reloadAllComponents()
        }
        if pickerView.tag == 1 || pickerView.tag == 2 {
            if pickerView.selectedRow(inComponent: 0) != 0 && pickerView.selectedRow(inComponent: 1) == 0 {
                pickerView.selectRow(1, inComponent: 1, animated: true)
            }
            if pickerView.selectedRow(inComponent: 0) == 0 {
                pickerView.selectRow(0, inComponent: 1, animated: true)
            }
        }
        
    }
}

protocol FiltersViewControllerDelegate: AnyObject {
    func filtersViewController(_ filtersViewController: FiltersViewController,didApplyFilters: [String: String])
}
