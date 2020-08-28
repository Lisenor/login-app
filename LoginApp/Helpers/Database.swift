//
//  Database.swift
//  LoginApp
//
//  Created by Leah Isenor on 2020-08-08.
//  Copyright © 2020 Leah Isenor. All rights reserved.
//

import FirebaseAuth
import Firebase
class Database {
    
    
    
    static let db = Firestore.firestore()
    
    //TODO wrap closure params in struct to retain labels
    
    //function to create a new user
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

    //function to add users info to db
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
      
    static func signIn(email: String, password: String, completion: @escaping (_ uid: String,_ error: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if err != nil {
                completion("",err!.localizedDescription)
            } else {
                completion(result!.user.uid, "") //NOT WORKING
            }
        }
    }
    
}
     
