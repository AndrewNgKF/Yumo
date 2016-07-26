//
//  TutorialPageViewController.swift
//  Yumo
//
//  Created by IMAC on 26/7/16.
//  Copyright © 2016 Andrew Ng. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController,UIPageViewControllerDataSource {
    
    weak var tutorialDelegate: TutorialPageViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .Forward,
                               animated: true,
                               completion: nil)
        }
        
        tutorialDelegate?.tutorialPageViewController(self,
                                                     didUpdatePageCount: orderedViewControllers.count)
        
        stylePageControl()
        
    }


    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newColoredViewController("Green"),
                self.newColoredViewController("Red"),
                self.newColoredViewController("Blue")]
    }()
    
    private func newColoredViewController(color: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewControllerWithIdentifier("\(color)ViewController")
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    
    
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            firstViewControllerIndex = orderedViewControllers.indexOf(firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
    private func stylePageControl() {
        let pageControl = UIPageControl.appearanceWhenContainedInInstancesOfClasses([self.dynamicType])
        
        pageControl.currentPageIndicatorTintColor = UIColor.init(colorLiteralRed: 1, green: 0, blue: 0, alpha: 1)
        pageControl.pageIndicatorTintColor = UIColor.blackColor()
        pageControl.backgroundColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 1, alpha: 0)
    }

    
    
}

extension TutorialPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                                               previousViewControllers: [UIViewController],
                                               transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.indexOf(firstViewController) {
            tutorialDelegate?.tutorialPageViewController(self,
                                                         didUpdatePageIndex: index)
        }
    }
    
}

protocol TutorialPageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageIndex index: Int)
    
}
