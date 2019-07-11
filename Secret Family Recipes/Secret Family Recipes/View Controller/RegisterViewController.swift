//
//  RegisterViewController.swift
//  Secret Family Recipes
//
//  Created by Sergey Osipyan on 7/8/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

import UIKit

enum LoginType {
    
    case register
    case login
}

class RegisterViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var registeredButton: UIButton!


    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        if let username = loginTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let repeatPassword = repeatPasswordTextField.text, !repeatPassword.isEmpty {
            if password != repeatPassword { displayMyAlertMessage(userMessage: "Passwords do not match")}
            let user = User(username: username, password: password)
            
                LoginController.shared.register(with: user) { (bool) in
                    if bool {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Sign up Successful", message: "Now please log in.", preferredStyle: .alert)
                            
                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                self.dismiss(animated: true, completion: nil)
                            })
                            alertController.addAction(alertAction)
                            self.present(alertController, animated: true, completion: {
                            
                            })
                        }
                    } else {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Sign up Unsuccessful", message: "Please try diferent login", preferredStyle: .alert)
                            
                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                self.dismiss(animated: true, completion: nil)
                            })
                            alertController.addAction(alertAction)
                            self.present(alertController, animated: true, completion: {
                                
                            })
                        }
                    }
                    }
        } else {
            displayMyAlertMessage(userMessage: "Marked fields are required")
        }
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        emailTextField.delegate = self
        loginTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        addressTextField.delegate = self
        phoneNumberTextField.delegate = self
        setupAppearance()

    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        addressTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        registeredButton.resignFirstResponder()
        repeatPasswordTextField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


    private func setupAppearance() {

        ThemeHelper.textFieldStyle(for: nameTextField)
        ThemeHelper.textFieldStyle(for: emailTextField)
        ThemeHelper.textFieldStyle(for: loginTextField)
        ThemeHelper.textFieldStyle(for: passwordTextField)
        ThemeHelper.textFieldStyle(for: repeatPasswordTextField)
        ThemeHelper.textFieldStyle(for: addressTextField)
        ThemeHelper.textFieldStyle(for: phoneNumberTextField)
        ThemeHelper.buttonStyle(for: registeredButton)

     view.backgroundColor = ThemeHelper.customBlue

    }
    
    func displayMyAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: .alert);
        let okAction = UIAlertAction(title:"Ok", style: .default, handler:nil);
        myAlert.addAction(okAction);
        self.present(myAlert, animated:true, completion:nil);
    }

}
