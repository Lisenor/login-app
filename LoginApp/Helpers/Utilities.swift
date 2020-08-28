//
//  Utilities.swift
//  customauth
//
//  Created by Christopher Ching on 2019-05-09.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class Utilities {
    static let db = Firestore.firestore()
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    

    //move to database
    //TODO wrap closure params in struct to retain labels
    static func createUser(email:String, password: String, completion: @escaping (_ uid: String, _ err: String)-> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                // Error creating new user.
                completion("",error!.localizedDescription)
                
            } else {
                // Create successfully.
                completion(user!.user.uid,"")
            }
        }
    }
     
    
    static func addUser(firstName: String, lastName: String, uid: String,
                        completion: @escaping (_ uid: String, _ err: String) -> Void) {
    
        db.collection("users").addDocument(data: ["firstName" : firstName, "lastName" : lastName, "uid" : uid]) { (error) in
           
            if error != nil {
                 completion(uid, error!.localizedDescription)
            } else {
                 completion(uid,"")
            }
        }
    
    }
    
    
    static func showError(error: String, errorLabel: UILabel) {
        errorLabel.text = error
        errorLabel.alpha = 1
    }
       
    static func hideError(errorLabel: UILabel) {
        errorLabel.alpha = 0
    }
    
}
