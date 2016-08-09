//
//  StoryViewController.swift
//  FarmLead
//
//  Created by Zoumite Franck Armel Mamboue on 2016-08-09.
//  Copyright © 2016 Zoumite Franck Armel Mamboue. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
    
    // UI Connections
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var done: UIButton!
    
    // Variables
    var titleText: String?
    var descriptionText: String?
    var imageFileName: String?
    var showDone: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func initializeStory(titleText: String, descriptionText: String, imageFileName: String, showDone: Bool? = false) {
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.imageFileName = imageFileName
        self.showDone = showDone
    }
    
    func setupViews() {
        titleLabel.text = titleText
        descriptionLabel.text = descriptionText
        if let imageFileName = imageFileName {
            image.image = UIImage(named: imageFileName)!
        }
        if let showDone = showDone where showDone {
            self.done.hidden = false
        } else {
            self.done.hidden = true
        }
        self.done.setTitle(NSLocalizedString("DONE", comment: ""), forState: .Normal)
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        print("TODO: Done clicked")
    }
}
