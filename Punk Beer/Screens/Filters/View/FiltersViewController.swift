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
    @IBOutlet weak var abvGreaterTextField: UITextField!
    @IBOutlet weak var abvLessTextField: UITextField!
    
    //MARK: - Actions
    @IBAction func removeFiltersButtonTapped(_ sender: Any) {
    }
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Functions
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
        
    }

}
