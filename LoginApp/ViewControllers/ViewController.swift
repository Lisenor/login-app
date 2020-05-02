//
//  ViewController.swift
//  LoginApp
//
//  Created by Leah Isenor on 2020-04-29.
//  Copyright © 2020 Leah Isenor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpElements()
    }
    
    func setUpElements() {

        //style elements
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
        
    @IBAction func signUpTapped(_ sender: Any) {
    }
    
    @IBAction func loginTapped(_ sender: Any) {
    }
    
}

