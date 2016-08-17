//
//  OnBoardViewController.swift
//  FarmLead
//
//  Created by Zoumite Franck Armel Mamboue on 2016-08-09.
//  Copyright © 2016 Zoumite Franck Armel Mamboue. All rights reserved.
//
// This class represents a container view controller that holds the page control and the story board view controller

import UIKit

class OnBoardViewController: UIViewController {
    
    //MARK: UI Connections
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: View life cycle
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let onBoardPageViewController = segue.destinationViewController as? OnBoardPageViewController {
            onBoardPageViewController.onBoardDelegate = self
        }
    }
    
}

//MARK: Protocol implementation
extension OnBoardViewController: OnBoardPageViewControllerDelegate {
    
    func onBoardPageViewController(onBoardPageViewController: OnBoardPageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func onBoardPageViewController(onBoardPageViewController: OnBoardPageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}