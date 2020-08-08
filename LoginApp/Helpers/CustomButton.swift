//
//  CustomButton.swift
//  LoginApp
//
//  Created by Leah Isenor on 2020-08-08.
//  Copyright © 2020 Leah Isenor. All rights reserved.
//

import UIKit
class CustomButton: UIButton {
      
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpButton()
    }
    
    func setUpButton(){
        
    }
}

