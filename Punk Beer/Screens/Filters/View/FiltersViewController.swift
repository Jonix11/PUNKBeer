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
    
    
    //MARK: - Actions
    @IBAction func removeFiltersButtonTapped(_ sender: Any) {
        abvPickerView.selectRow(0, inComponent: 0, animated: true)
        abvPickerView.selectRow(0, inComponent: 1, animated: true)
    }
    
    //MARK: - Properties
    var filters: [String: String]
    weak var delegate: FiltersViewControllerDelegate?
    let ABV_PICKER_NUMBERS_ROWS = 61
    
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
        abvPickerView.delegate = self
        abvPickerView.dataSource = self
        setupUI()
        syncFiltersWithView()
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
    }

}

extension FiltersViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
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
        
    }
    
    
}

extension FiltersViewController: UIPickerViewDelegate {
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

protocol FiltersViewControllerDelegate: AnyObject {
    func filtersViewController(_ filtersViewController: FiltersViewController,didApplyFilters: [String: String])
}
