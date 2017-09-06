//
//  MasticNavigationController.swift
//  design
//
//  Created by Tomer Goldfeder on 04/09/2017.
//  Copyright © 2017 Tomer Goldfeder. All rights reserved.
//

import UIKit

public class MasticNavigationController: UINavigationController {
    
    
    var scrollView: UIScrollView?
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: nil) {[weak self] (completion) in
            if let `self` = self,
                self.automaticallyAdjustsScrollViewInsets {
                self.navigationBar.updateInsets(statusVisable: self.isStatusBarVisable)
            }
        }
        
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) {[weak self] _ in
                self?.navigationBar.didPush()
            }
        } else {
            navigationBar.didPush()
        }
    }
    
    public override func popViewController(animated: Bool) -> UIViewController? {
        defer {
            navigationBar.didPush()
        }
        return super.popViewController(animated: animated)
    }
}

extension UINavigationController {
    
    func hook(scrollView: UIScrollView,inside: UIViewController){
        if self is MasticNavigationController {
            (self as! MasticNavigationController).scrollView = scrollView
        }
        
        inside.automaticallyAdjustsScrollViewInsets = false
        navigationBar.hook(scrollView: scrollView)
        navigationBar.updateInsets(statusVisable: isStatusBarVisable)
    }
    
    fileprivate var isStatusBarVisable: Bool {
        return !UIApplication.shared.isStatusBarHidden
    }
}
