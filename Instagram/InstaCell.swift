//
//  InstaCell.swift
//  Instagram
//
//  Created by Madel Asistio on 3/12/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit
import Parse

class InstaCell: UITableViewCell {

    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    var currPost: PFObject!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postImage.image = currPost.object(forKey: "media") as! UIImage?
        captionLabel.text = currPost.object(forKey: "caption") as! String
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
