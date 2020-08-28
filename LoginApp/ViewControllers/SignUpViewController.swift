//
//  SignUpViewController.swift
//  LoginApp
//
//  Created by Leah Isenor on 2020-04-29.
//  Copyright © 2020 Leah Isenor. All rights reserved.
//

import UIKit
class SignUpViewController: UIViewController {

    //outlets
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
        
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: CustomButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
 
    }
    
    func setUpElements() {
        //hide error label
        errorLabel.alpha = 0
    }

    //validates input fields and returns error message if problem
    
    //move to utilities
    func validateFields() -> String? {
        //all fields filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in all fields"
        }
        
        //check password is secure
        if passwordTextField.text! != confirmPasswordTextField.text! {
            return "Passwords do not match"
        }
        
        if !Utilities.isPasswordValid(passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) {
            return "Please make sure your password is at least 8 characters, contains a special character and a number "
        }
        
        //TODO: add email check - already built into firestore auth
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
    
        Utilities.hideError(errorLabel: errorLabel)
        //validate fields
        let error = validateFields()
        if error != nil {
            //error found in validation, db not queried
            Utilities.showError(error: error!,errorLabel: errorLabel)
        } else {
            
            
            //remove white spaces
            //REFACTOR so only does once
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            

            
            //create user
            Utilities.createUser(email: email, password: password) { (uid, error) in
                if error != "" {
                    Utilities.showError(error: error, errorLabel: self.errorLabel)
                } else {
                    Utilities.addUser(firstName: firstName, lastName: lastName, uid: uid) { (uid, err) in
                        if err != "" {
                            Utilities.showError(error: err, errorLabel: self.errorLabel)
                        } else {
                            self.transitionToHome()
                        }
                    }
                }
            }
        }
    }
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
}
