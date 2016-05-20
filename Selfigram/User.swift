//
//  User.swift
//  Selfigram
//
//  Created by Shawn Crisp on 2016-05-19.
//  Copyright © 2016 Shawn Crisp. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    let username : String
    let profileImage : UIImage
    
    
    init(inputUserName : String, inputProfileImage : UIImage){
        
        username = inputUserName
        profileImage = inputProfileImage
    }
}