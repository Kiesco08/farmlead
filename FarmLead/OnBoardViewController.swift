//
//  OnBoardViewController.swift
//  FarmLead
//
//  Created by Zoumite Franck Armel Mamboue on 2016-08-09.
//  Copyright © 2016 Zoumite Franck Armel Mamboue. All rights reserved.
//

import UIKit

class OnBoardViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var done: UIButton!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let onBoardPageViewController = segue.destinationViewController as? OnBoardPageViewController {
            onBoardPageViewController.onBoardDelegate = self
        }
    }
    
}

extension OnBoardViewController: OnBoardPageViewControllerDelegate {
    
    func onBoardPageViewController(onBoardPageViewController: OnBoardPageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func onBoardPageViewController(onBoardPageViewController: OnBoardPageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}