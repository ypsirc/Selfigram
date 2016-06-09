//
//  Post.swift
//  Selfigram
//
//  Created by Shawn Crisp on 2016-05-19.
//  Copyright © 2016 Shawn Crisp. All rights reserved.
//

import Foundation
import UIKit
import Parse

class Post: PFObject, PFSubclassing {
    
    @NSManaged var image:PFFile
    @NSManaged var user:PFUser
    @NSManaged var comment:String
    
    static func parseClassName() -> String {
        return "Post"
    }
    
    // convenience init method, because it’s building on top of PFObject’s init, rather than overriding it.
    convenience init(image:PFFile, user:PFUser, comment:String){
        // You can name the property you are passing into the function the
        // same name as the class' property. To distinguish the two
        // add "self." to the beginning of the class' property.
        self.init()
        self.image = image
        self.user = user
        self.comment = comment
    }
    
//    let imageURL : NSURL
//    let user : User
//    let comment : String
//    
//    init(inputImage : NSURL, inputUser : User, inputComment : String) {
//        self.imageURL = inputImage
//        self.user = inputUser
//        self.comment = inputComment
//    }

}