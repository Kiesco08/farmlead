//
//  SummaryViewController.swift
//  FarmLead
//
//  Created by Zoumite Franck Armel Mamboue on 2016-08-16.
//  Copyright © 2016 Zoumite Franck Armel Mamboue. All rights reserved.
//
// This class shows the summary of the user selection

import UIKit

class SummaryViewController: UIViewController {

    //MARK: UI Connections
    @IBOutlet weak var summaryLabel: UILabel!
    
    //MARK: Variables
    var city = NSLocalizedString("an unknown location", comment: "")
    var unit = NSLocalizedString("an unspecified unit", comment: "")
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("Summary", comment: "")
        
        setupViews()
    }
    
    //MARK: Functions
    func setupViews() {
        initializeSummaryLabel()
    }
    
    func initializeSummaryLabel() {
        summaryLabel.text = NSLocalizedString("You are located in \(city) and you prefer to deal with \(unit).", comment: "")
    }
}
