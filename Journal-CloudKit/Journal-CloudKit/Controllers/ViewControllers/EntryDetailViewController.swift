//
//  EntryDetailViewController.swift
//  Journal-CloudKit
//
//  Created by Ian Becker on 8/17/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - Properties
    var entry: Entry? {
        didSet {
            DispatchQueue.main.async {
                self.loadViewIfNeeded()
                self.updateViews()
            }
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
    }
    
    // MARK: - Actions
    @IBAction func mainViewTapped(_ sender: Any) {
        titleTextField.resignFirstResponder()
        bodyTextView.resignFirstResponder()
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty, let bodyText = bodyTextView.text, !bodyText.isEmpty else {return}
        
        EntryController.sharedInstance.saveEntry(with: title, bodyText: bodyText) { (result) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // MARK: - Helper Functions
    func updateViews() {
        guard let entry = entry else {return}
        titleTextField.text = entry.title
        bodyTextView.text = entry.bodyText
    }
} // End of class

extension EntryDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
} // End of extension
