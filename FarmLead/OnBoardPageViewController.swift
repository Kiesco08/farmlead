//
//  OnBoardPageViewController.swift
//  FarmLead
//
//  Created by Zoumite Franck Armel Mamboue on 2016-08-09.
//  Copyright © 2016 Zoumite Franck Armel Mamboue. All rights reserved.
//

import UIKit

class OnBoardPageViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    var onBoardDelegate: OnBoardPageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        let page1 = storyboard?.instantiateViewControllerWithIdentifier("StoryViewController") as! StoryViewController
        page1.initializeStory(NSLocalizedString("Find a deal", comment: ""), descriptionText: NSLocalizedString("Search or post grain deals", comment: ""), imageFileName: "intro-screen-img-1")
        
        let page2 = storyboard?.instantiateViewControllerWithIdentifier("StoryViewController") as! StoryViewController
        page2.initializeStory(NSLocalizedString("Negotiate your deal", comment: ""), descriptionText: NSLocalizedString("Set the terms anonymously", comment: ""), imageFileName: "intro-screen-img-2")
        
        let page3 = storyboard?.instantiateViewControllerWithIdentifier("StoryViewController") as! StoryViewController
        page3.initializeStory(NSLocalizedString("Close the deal", comment: ""), descriptionText: NSLocalizedString("Complete the sale", comment: ""), imageFileName: "intro-screen-img-3")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        setViewControllers([page1], direction: .Forward, animated: true, completion: nil)
        
        onBoardDelegate?.onBoardPageViewController(self, didUpdatePageCount: pages.count)
    }
}

extension OnBoardPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.indexOf(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard pages.count > previousIndex else {
            return nil
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = pages.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return pages[nextIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                           previousViewControllers: [UIViewController],
                           transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let index = pages.indexOf(firstViewController) {
            onBoardDelegate?.onBoardPageViewController(self, didUpdatePageIndex: index)
        }
    }
}

protocol OnBoardPageViewControllerDelegate: class {
    
    // Called when the number of pages is updated
    func onBoardPageViewController(OnBoardPageViewController: OnBoardPageViewController, didUpdatePageCount count: Int)
    
    // Called when the current index is updated
    func onBoardPageViewController(OnBoardPageViewController: OnBoardPageViewController, didUpdatePageIndex index: Int)
    
}