//
//  SwipeAwayTableViewController.swift
//  ScantronKit
//
//  Created by Nate Parrott on 9/30/14.
//  Copyright (c) 2014 Nate Parrott. All rights reserved.
//

import UIKit

class SwipeAwayTableViewController: UITableViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    var contentBackdrop: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollViewDidScroll(tableView)
        
        tableView.tableHeaderView = UIView(frame: CGRectMake(0, 0, 1, topMargin()))
        let tapRec = UITapGestureRecognizer(target: self, action: "dismiss")
        tableView.tableHeaderView!.addGestureRecognizer(tapRec)
        
        contentBackdrop = UIView()
        contentBackdrop.backgroundColor = UIColor.whiteColor()
        tableView.insertSubview(contentBackdrop, atIndex: 0)
        
        tableView.backgroundColor = UIColor.clearColor()
        
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, topMargin(), 0, 0)
    }
    
    func topMargin() -> CGFloat {
        return 60
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        view.setNeedsLayout()
    }

    // MARK: Transitioning
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.7
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let isDismissal = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) == self
        let duration = transitionDuration(transitionContext)
        let containerView = transitionContext.containerView()
        let dimmingView = UIView(frame: containerView.bounds)
        if isDismissal {
            containerView.insertSubview(dimmingView, belowSubview: self.view)
            dimmingView.backgroundColor = tableView.backgroundColor
            tableView.backgroundColor = UIColor.clearColor()
            UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: -dismissVelocity / containerView.bounds.size.height, options: nil, animations: { () -> Void in
                self.view.transform = CGAffineTransformMakeTranslation(0, containerView.bounds.size.height)
                dimmingView.alpha = 0
                }, completion: { (_) -> Void in
                    self.view.removeFromSuperview()
                    dimmingView.removeFromSuperview()
                    transitionContext.completeTransition(true)
            })
        } else {
            containerView.addSubview(dimmingView)
            dimmingView.backgroundColor = UIColor.clearColor()
            containerView.addSubview(self.view)
            self.view.frame = transitionContext.finalFrameForViewController(self)
            self.view.transform = CGAffineTransformMakeTranslation(0, containerView.bounds.size.height)
            tableView.backgroundColor = UIColor.clearColor()
            UIView.animateWithDuration(duration, animations: { () -> Void in
                self.view.transform = CGAffineTransformIdentity
                dimmingView.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
                }, completion: { (_) -> Void in
                    dimmingView.removeFromSuperview()
                    self.scrollViewDidScroll(self.tableView)
                    transitionContext.completeTransition(true)
            })
        }
    }
    
    // MARK: Interaction
    var isDismissing = false
    @IBAction func dismiss() {
        isDismissing = true
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    var dismissVelocity: CGFloat = 1
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.contentOffset.y < -10 && velocity.y < -1 {
            dismissVelocity = velocity.y
            dismiss()
        }
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if !isDismissing {
            let scrollUpProportion: CGFloat = -scrollView.contentOffset.y / (view.bounds.size.height - topMargin())
            let fadeOut: CGFloat = min(1.0, max(0.0, scrollUpProportion))
            tableView.backgroundColor = UIColor(white: 0.1, alpha: (1 - fadeOut) * 0.5)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentBackdrop.frame = CGRectMake(0, topMargin(), view.bounds.size.width, tableView.contentSize.height + view.bounds.size.height)
    }
}
