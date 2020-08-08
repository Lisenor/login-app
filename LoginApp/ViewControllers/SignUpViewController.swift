//
//  SignUpViewController.swift
//  LoginApp
//
//  Created by Leah Isenor on 2020-04-29.
//  Copyright © 2020 Leah Isenor. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
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
        Utilities.hideError(errorLabel)
        //validate fields
        let error = validateFields()
        if error != nil {
            //error found
            Utilities.showError(error!,errorLabel)
        } else {
        
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            //create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                //check for errors
                //err will be nil if no error occurs
                if err != nil {
                    //error creating user
                     Utilities.showError(err!.localizedDescription,self.errorLabel)
                } else {
                    
                    //user created successfully
                    //store first and last name
                    let db = Firestore.firestore()
                    
                 
                    db.collection("users").addDocument(data: ["firstName" : firstName, "lastName" : lastName, "uid" : result!.user.uid]) { (error) in
                        if error != nil {
                             Utilities.showError(error!.localizedDescription,self.errorLabel)
                        } else {
                            //transition to home screen
                             self.transitionToHome()
                        }
                    }
                    //TODO: what to do if user created but data not saved?
                           
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
