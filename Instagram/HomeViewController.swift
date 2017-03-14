//
//  HomeViewController.swift
//  Instagram
//
//  Created by Madel Asistio on 3/12/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, CaptionDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    var instaPosts: [PFObject] = []
    var captionPost: String!
    var imagePost: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // construct query
        let query = PFQuery(className: "Post")
        query.limit = 20
        
         // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                // do something with the array of object returned by the call
                
                for i in (0...posts.count-1).reversed() {
                    self.instaPosts.append(posts[i])
                }
                
               // self.instaPosts = posts
                self.tableView.reloadData()
                
            } else {
                print(error?.localizedDescription)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
       // let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        let newSize = CGSize(width: 300, height: 300)
        imagePost = resizeImg(image: originalImage, newSize: newSize)
        dismiss(animated: false, completion: nil)
        performSegue(withIdentifier: "postSegue", sender: nil)
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
    
    }
    
    func addCaption(_ caption: String) {
        
        captionPost = caption
       
        let posted = InstaPost.postUserImage(image: imagePost, withCaption: caption) { (success: Bool, error: Error?) in
            print("picture posted")
            self.tableView.reloadData()
        }
        
        self.instaPosts.insert(posted, at: 0)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.instaPosts != nil {
            return self.instaPosts.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "InstaCell", for: indexPath) as! InstaCell
        
        cell.currPost = instaPosts[indexPath.row]
        
        return cell
    }

    @IBAction func logoutUser(_ sender: Any) {
        
        PFUser.logOutInBackground { (error: Error?) in
            print ("logged out")
        }
    }
    @IBAction func addPost(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(vc, animated: true, completion: nil)
    }
    
    func resizeImg(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using
        if segue.identifier == "postSegue" {
            let captionVC = segue.destination as! CaptionViewController
            captionVC.delegate = self
        }
        // Pass the selected object to the new view controller.
        
    }


}
