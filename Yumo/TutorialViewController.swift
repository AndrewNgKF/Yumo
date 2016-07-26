//
//  TutorialViewController.swift
//  Yumo
//
//  Created by IMAC on 26/7/16.
//  Copyright © 2016 Andrew Ng. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let tutorialPageViewController = segue.destinationViewController as? TutorialPageViewController {
            tutorialPageViewController.tutorialDelegate = self
        }
    }
  
    
}

extension TutorialViewController: TutorialPageViewControllerDelegate {
    
    func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}