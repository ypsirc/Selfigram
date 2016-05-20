//
//  Post.swift
//  Selfigram
//
//  Created by Shawn Crisp on 2016-05-19.
//  Copyright © 2016 Shawn Crisp. All rights reserved.
//

import Foundation
import UIKit

class Post {
    
    let image : UIImage
    let user : User
    let comment : String
    
    init(inputImage : UIImage, inputUser : User, inputComment : String) {
        self.image = inputImage
        self.user = inputUser
        self.comment = inputComment
    }
    
}