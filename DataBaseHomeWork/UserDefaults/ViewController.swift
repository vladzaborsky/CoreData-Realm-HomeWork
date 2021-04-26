//
//  ViewController.swift
//  DataBaseHomeWork
//
//  Created by Влад Заборский on 23.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSetTitle()
        setDataToLabel()
        
        
    }

    // Set value to UserDefaults
    @IBAction func sendButtonTapped(_ sender: Any) {
        
        if (nameTextField.text != "" && surnameTextField.text != "") {
            Persistence.shared.userName = self.nameTextField.text
            Persistence.shared.userSurname = self.surnameTextField.text
        } else {
            self.userNameLabel.text = "Введите имя и фамилию"
        }
        
        
    }
    
    // Set Button Title
    func buttonSetTitle() {
        
        self.sendButton.setTitle("Send", for: .normal)
    }
    
    // Set Data to userNameLabel
    func setDataToLabel() {
        
        guard let name = Persistence.shared.userName else { return }
        guard let userSurname = Persistence.shared.userSurname else { return }
        
        self.userNameLabel.text = "\(name) \(userSurname)"
    }
    
    
    
}

