//
//  HomeViewController.swift
//  Instagram
//
//  Created by Madel Asistio on 3/12/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    var instaPosts: [PFObject]!

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
                
                self.instaPosts = posts
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
       
        InstaPost.postUserImage(image: originalImage, withCaption: "") { (success: Bool, error: Error?) in
            
        }
        tableView.reloadData()
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.instaPosts != nil {
            print("COUNT IS \(self.instaPosts!.count)")
            return self.instaPosts!.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "InstaCell", for: indexPath) as! InstaCell
        
        cell.currPost = instaPosts[indexPath.row]
        print(cell.currPost)
        
        return cell
    }

    @IBAction func logoutUser(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addPost(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(vc, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
