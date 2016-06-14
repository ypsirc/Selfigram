//
//  Activity.swift
//  Selfigram
//
//  Created by Shawn Crisp on 2016-06-09.
//  Copyright © 2016 Shawn Crisp. All rights reserved.
//

import Parse

class Activity:PFObject, PFSubclassing {
    
    @NSManaged var type:String
    @NSManaged var post:Post
    @NSManaged var user:PFUser
    
    static func parseClassName() -> String {
        return "Activity"
    }
    
    convenience init(type:String, post:Post, user:PFUser){
        self.init()
        self.type = type
        self.post = post
        self.user = user
    }
    
}