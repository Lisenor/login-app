//
//  LoginViewController.swift
//  LoginApp
//
//  Created by Leah Isenor on 2020-04-29.
//  Copyright © 2020 Leah Isenor. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var loginButton: CustomButton!
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements() {
        
        // MARK: - delete
        emailTextField.text = "test@mail.com"
        passwordTextField.text = "Testuser@123"
        //hide error label
        errorLabel.alpha = 0
    }

   
    @IBAction func loginTapped(_ sender: Any) {
        Utilities.hideError(errorLabel: errorLabel)
        //validate fields
        
        let error = validateFields()
        if error != nil {
            //error found
            Utilities.showError(error: error!,errorLabel: errorLabel)
        } else {
        
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                   
            //sign in
            Database.signIn(email: email, password: password) { (uid, err) in
                if err != "" {
                    Utilities.showError(error: err, errorLabel: self.errorLabel)
                } else {
                     //TODO: login user-user class with uid
                    self.transitionToHome()
                }
            }
        }
    }
    
    //validates input fields and returns error message if problem
    func validateFields() -> String? {
        //all fields filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        return nil
    }
    
    func transitionToHome() {
            
        //TODO: move to utilities??
         let navigationController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.navigationController) as? UINavigationController
        
         //present(navigationController!, animated: true, completion: nil)
         view.window?.rootViewController = navigationController
         view.window?.makeKeyAndVisible()
      }
    
       
} 
