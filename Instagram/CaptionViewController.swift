//
//  CaptionViewController.swift
//  Instagram
//
//  Created by Madel Asistio on 3/14/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit

protocol CaptionDelegate: class {
    func addCaption(_ caption: String)
}

class CaptionViewController: UIViewController {

    @IBOutlet weak var captionField: UITextView!
    
    var img: UIImage!
    
    weak var delegate: CaptionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captionField!.layer.borderWidth = 1
        captionField!.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addCaption(_ sender: Any) {
        print("caption added")
         self.dismiss(animated: true, completion: nil)
        self.delegate?.addCaption(captionField.text)
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
