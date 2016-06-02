//
//  FeedTableViewController.swift
//  Selfigram
//
//  Created by Shawn Crisp on 2016-05-24.
//  Copyright © 2016 Shawn Crisp. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
        
//        let me = User(inputUserName: "danny", inputProfileImage: UIImage(named: "Grumpy-Cat")!)
        
//        let post0 = Post(inputImage: UIImage(named: "Grumpy-Cat")!, inputUser: me, inputComment: "Grumpy Cat 0")
//        let post1 = Post(inputImage: UIImage(named: "Grumpy-Cat")!, inputUser: me, inputComment: "Grumpy Cat 1")
//        let post2 = Post(inputImage: UIImage(named: "Grumpy-Cat")!, inputUser: me, inputComment: "Grumpy Cat 2")
//        let post3 = Post(inputImage: UIImage(named: "Grumpy-Cat")!, inputUser: me, inputComment: "Grumpy Cat 3")
//        let post4 = Post(inputImage: UIImage(named: "Grumpy-Cat")!, inputUser: me, inputComment: "Grumpy Cat 4")
//        
//        
//        posts = [post0, post1, post2, post3, post4]
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=1f7ea864ac648ab1ea9824779d833337&tags=giraffe")!) { (data, response, error) -> Void in
            
            
            if let jsonUnformatted = try? NSJSONSerialization.JSONObjectWithData(data!, options: []),
                let json = jsonUnformatted as? [String : AnyObject],
                let photosDictionary = json["photos"] as? [String : AnyObject],
                let photosArray = photosDictionary["photo"] as? [[String : AnyObject]]
            {
                
                for photo in photosArray {
                    
                    if let farmID = photo["farm"] as? Int,
                        let serverID = photo["server"] as? String,
                        let photoID = photo["id"] as? String,
                        let secret = photo["secret"] as? String {
                       
                        print ("inside dataTaskWithURL")
                        let photoURLString = "https://farm\(farmID).staticflickr.com/\(serverID)/\(photoID)_\(secret).jpg"
                        if let photoURL = NSURL(string: photoURLString){
                            let me = User(inputUserName: "danny", inputProfileImage: UIImage(named: "Grumpy-Cat")!)
                            let post = Post(inputImage: photoURL, inputUser: me, inputComment: "A Flickr Selfie")
                            self.posts.append(post)
                        }
                    }
                    
                }
                
                // We use dispatch_async because we need update all UI elements on the main thread.
                // This is a rule and you will see this again whenever you are updating UI.
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
                
            }else{
                print("error with response data")
            }
            
        }
        
        task.resume()
        
        print ("outside dataTaskWithURL")

        
        
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
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! SelfieCell
        
        
//        let post = self.posts[indexPath.row]

//        cell.selfieImageView.image = post.image
//        cell.usernameLabel.text = post.user.username
//        cell.commentLabel.text = post.comment
//      cell.imageView?.image = post.image
//      cell.textLabel?.text = post.comment
        
        let post = self.posts[indexPath.row]
        
        
        // I've added this line to prevent flickering of images
        // We are inside the cellForRowAtIndexPath method that gets called everything we layout a cell
        // Because we are reusing "postCell" cells, a reused cell might have an image already set on it.
        // This always resets the image to blank, waits for the image to download, and then sets it
        cell.selfieImageView.image = nil
        
        let task = NSURLSession.sharedSession().downloadTaskWithURL(post.imageURL) { (url, response, error) -> Void in
            
            if let imageURL = url,
                let imageData = NSData(contentsOfURL: imageURL){
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    cell.selfieImageView.image = UIImage(data: imageData)
                    
                })
            }
        }
        
        task.resume()
        
        cell.usernameLabel.text = post.user.username
        cell.commentLabel.text = post.comment
        
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
        
//        // 1. When the delegate method is returned, it passes along a dictionary called info.
//        //    This dictionary contains multiple things that maybe useful to us.
//        //    We are getting an image from the UIImagePickerControllerOriginalImage key in that dictionary
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            
//            //2. We create a Post object from the image
//            let me = User(inputUserName: "danny", inputProfileImage: UIImage(named: "Grumpy-Cat")!)
//            let post = Post(inputImage: image, inputUser: me, inputComment: "My Selfie")
//            
//            //3. Add post to our posts array
//            //    Adds it to the very top of our array (and therefore our table, when we pi
//            posts.insert(post, atIndex: 0)
//            
//        }
//        
//        //4. We remember to dismiss the Image Picker from our screen.
//        dismissViewControllerAnimated(true, completion: nil)
//        
//        //5. Now that we have added a post, reload our table
//        tableView.reloadData()
        
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
