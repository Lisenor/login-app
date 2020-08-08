//
//  LoginViewController.swift
//  LoginApp
//
//  Created by Leah Isenor on 2020-04-29.
//  Copyright © 2020 Leah Isenor. All rights reserved.
//

import UIKit
import Firebase
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
        //style elements
       // Utilities.styleTextField(emailTextField)
      //  Utilities.styleTextField(passwordTextField)
      //  Utilities.styleFilledButton(loginButton)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginTapped(_ sender: Any) {
        hideError()
        //validate fields
        
        let error = validateFields()
        if error != nil {
            //error found
            showError(error!)
        } else {
        
        
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                   
            //sign in
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    self.showError(error!.localizedDescription)
                } else {
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
            
        //TODO: - fix navigation / view controllers
        
         let navigationController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.navigationController) as? UINavigationController
        
         //present(navigationController!, animated: true, completion: nil)
         view.window?.rootViewController = navigationController
         // view.window?.makeKeyAndVisible()
      }
    
    func showError(_ error:String) {
        errorLabel.text = error
        errorLabel.alpha = 1
    }
    
    func hideError() {
        errorLabel.alpha = 0
    }
       
} 
