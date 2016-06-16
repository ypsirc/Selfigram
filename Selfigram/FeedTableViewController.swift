//
//  FeedTableViewController.swift
//  Selfigram
//
//  Created by Shawn Crisp on 2016-05-24.
//  Copyright © 2016 Shawn Crisp. All rights reserved.
//

import UIKit
import Parse

class FeedTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var words = ["Hello", "my", "name", "is", "Selfigram"]
    
    var posts = [Post]()
    
    func getPosts() {
        if let query = Post.query() {
            query.orderByDescending("createdAt")
            query.includeKey("user")
            query.findObjectsInBackgroundWithBlock({ (posts, error) -> Void in
                
                if let posts = posts as? [Post]{
                    self.posts = posts
                    self.tableView.reloadData()
                    // remove the spinning circle if needed
                    self.refreshControl?.endRefreshing()
                }
                
            })
        }
    }

    
    @IBAction func doubleTappedSelfie(sender: UITapGestureRecognizer) {
        
        print("double tapped selfie")
        
        // get the location (x,y) position on our tableView where we have clicked
        let tapLocation = sender.locationInView(tableView)
        
        // based on the x, y position we can get the indexPath for where we are at
        if let indexPathAtTapLocation = tableView.indexPathForRowAtPoint(tapLocation){
            
            // based on the indexPath we can get the specific cell that is being tapped
            let cell = tableView.cellForRowAtIndexPath(indexPathAtTapLocation) as! SelfieCell
            
            //run a method on that cell.
            cell.tapAnimation()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPosts()
        
    }
    
    
    @IBAction func refreshPulled(sender: UIRefreshControl) {
        
        getPosts()
        
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
        //return 5
        return self.posts.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! SelfieCell
        
        let post = self.posts[indexPath.row]
        
        cell.post = post
        
        return cell
    }
    
    
 
    @IBAction func cameraButtonPressed(sender: AnyObject) {
        
        
        print("Camera Button Pressed!")
        
        
        // 1: Create an ImagePickerController
        let pickerController = UIImagePickerController()
        
        // 2: Self in this line refers to this View Controller
        //    Setting the Delegate Property means you want to receive a message
        //    from pickerController when a specific event is triggered.
        pickerController.delegate = self
        
        if TARGET_OS_SIMULATOR == 1 {
            // 3. We check if we are running on a Simulator
            //    If so, we pick a photo from the simulator’s Photo Library
            // We need to do this because the simulator does not have a camera
            pickerController.sourceType = .PhotoLibrary
        } else {
            // 4. We check if we are running on an iPhone or iPad (ie: not a simulator)
            //    If so, we open up the pickerController's Camera (Front Camera, for selfies!)
            pickerController.sourceType = .Camera
            pickerController.cameraDevice = .Front
            pickerController.cameraCaptureMode = .Photo
        }
        
        // Preset the pickerController on screen
        self.presentViewController(pickerController, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // setting the compression quality to 90%
            if let imageData = UIImageJPEGRepresentation(image, 0.9),
                let imageFile = PFFile(data: imageData),
                let user = PFUser.currentUser(){
                
                //2. We create a Post object from the image
                let post = Post(image: imageFile, user: user, comment: "A Selfie")
                
                post.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if success {
                        print("Post successfully saved in Parse")
                        
                        //3. Add post to our posts array, chose index 0 so that it will be added
                        //   to the top of your table instead of at the bottom (default behaviour)
                        self.posts.insert(post, atIndex: 0)
                        
                        //4. Now that we have added a post, updating our table
                        //   We are just inserting our new Post instead of reloading our whole tableView
                        //   Both method would work, however, this gives us a cool animation for free
                        
                        let indexPath =  NSIndexPath(forRow: 0, inSection: 0)
                        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)

                        
                    }
                })
            }
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    
    
    
    
    // Override to support conditional editing of the table view.
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }


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
