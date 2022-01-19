//
//  ListProductUIControll.swift
//  TokopediaMiniProject
//
//  Created by Mac on 16/01/22.
//

import Foundation
import UIKit


class ListProductUIControll {
    private var controller: UIViewController?
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
}
extension ListProductUIControll: ListUIGuideHelper {
    public func showLoading(completion: (() -> Void)?) {
        guard let _controller = self.controller as? ListProductViewController else {
            return
        }
        var constraints = _controller.getLoadingView().constraints
        
        guard let getLoadingHeigh = constraints.firstIndex(where: { (constraint) -> Bool in
            constraint.identifier == "loadingViewHeight"
        }) else {
            return
        }
        NSLayoutConstraint.deactivate(constraints)
        UIView.animate(withDuration: 0.3, animations: {
            constraints[getLoadingHeigh] = NSLayoutConstraint(item: _controller.getLoadingView(), attribute: .height, relatedBy: .equal, toItem: _controller.view, attribute: .height, multiplier: 1/9, constant: 0)
            constraints[getLoadingHeigh].identifier = "loadingViewHeight"
            NSLayoutConstraint.activate(constraints)
            _controller.getLoadingSpinner().startAnimating()
            _controller.view.layoutIfNeeded()
        }, completion: { isFinish in
            if isFinish {
                completion?()
            }
        })
    }
    
    public func hideLoading(completion: (() -> Void)?) {
        guard let _controller = self.controller as? ListProductViewController else {
            return
        }
        var constraints = _controller.view.constraints
        
        guard let getLoadingHeigh = constraints.firstIndex(where: { (constraint) -> Bool in
            constraint.identifier == "loadingViewHeight"
        }) else {
            return
        }
        NSLayoutConstraint.deactivate(constraints)
        UIView.animate(withDuration: 0.3, animations: {
            constraints[getLoadingHeigh] = NSLayoutConstraint(item: _controller.getLoadingView(), attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
            constraints[getLoadingHeigh].identifier = "loadingViewHeight"
            NSLayoutConstraint.activate(constraints)
            _controller.getLoadingSpinner().stopAnimating()
            _controller.view.layoutIfNeeded()
        }, completion: { isFinish in
            if isFinish {
                completion?()
            }
        })
    }
    
    public func scrollControll(scrollView: UIScrollView, completion: (() -> Void)?) {
        
    }
    
    
}
