//
//  StoryViewController.swift
//  FarmLead
//
//  Created by Zoumite Franck Armel Mamboue on 2016-08-09.
//  Copyright © 2016 Zoumite Franck Armel Mamboue. All rights reserved.
//
// This class represents the template of a single story in the story board

import UIKit

class StoryViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    //MARK: UI Connections
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var done: UIButton!
    
    @IBAction func doneAction(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let personalizationTableViewController = mainStoryboard.instantiateViewControllerWithIdentifier("PersonalizationTableViewController") as! PersonalizationTableViewController
        let nav = UINavigationController(rootViewController: personalizationTableViewController)
        nav.modalPresentationStyle = UIModalPresentationStyle.Popover
        let popover = nav.popoverPresentationController
        personalizationTableViewController.preferredContentSize = CGSizeMake(self.view.bounds.width, self.view.bounds.height)
        popover!.sourceView = self.view
        
        self.presentViewController(nav, animated: true, completion: nil)
    }
    
    //MARK: Variables
    var titleText: String?
    var descriptionText: String?
    var imageFileName: String?
    var showDone: Bool?
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: Functions
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

}
