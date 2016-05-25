//
//  FeedTableViewController.swift
//  Selfigram
//
//  Created by Shawn Crisp on 2016-05-24.
//  Copyright © 2016 Shawn Crisp. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {

    var words = ["Hello", "my", "name", "is", "Selfigram"]
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // UIImage has an initializer where you can pass in the name of an image in your project to create an UIImage
        // UIImage(named: "grumpy-cat") can return nil if there is no image called "grumpy-cat" in your project
        // Our definition of Post did not include the possibility of a nil UIImage
        // so, therefore we have to add a ! at the end of it
        
        let me = User(inputUserName: "danny", inputProfileImage: UIImage(named: "Grumpy-Cat")!)
        
        let post0 = Post(inputImage: UIImage(named: "Grumpy-Cat")!, inputUser: me, inputComment: "Grumpy Cat 0")
        let post1 = Post(inputImage: UIImage(named: "Grumpy-Cat")!, inputUser: me, inputComment: "Grumpy Cat 1")
        let post2 = Post(inputImage: UIImage(named: "Grumpy-Cat")!, inputUser: me, inputComment: "Grumpy Cat 2")
        let post3 = Post(inputImage: UIImage(named: "Grumpy-Cat")!, inputUser: me, inputComment: "Grumpy Cat 3")
        let post4 = Post(inputImage: UIImage(named: "Grumpy-Cat")!, inputUser: me, inputComment: "Grumpy Cat 4")
        
        
        posts = [post0, post1, post2, post3, post4]
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath)
        
        let post = posts[indexPath.row]
        cell.imageView?.image = post.image
        cell.textLabel?.text = post.comment
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
