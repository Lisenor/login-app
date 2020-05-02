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
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    func setUpElements() {
        //hide error label
        errorLabel.alpha = 0
        //style elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
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
          let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
          
          view.window?.rootViewController = homeViewController
          view.window?.makeKeyAndVisible()
      }
    
    func showError(_ error:String) {
        errorLabel.text = error
        errorLabel.alpha = 1
    }
} 
