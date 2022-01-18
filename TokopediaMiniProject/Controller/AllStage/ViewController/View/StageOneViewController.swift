//
//  StageOneViewController.swift
//  TokopediaMiniProject
//
//  Created by Mac on 18/01/22.
//

import UIKit

class StageOneViewController: UIViewController {

    private let navBar = DefaultNavBar()
    private let emptySpaceNav = UIView()
    private let emptyContent = UIView()
    
    private lazy var productVC: UIViewController = {
        let vc = ListProductViewController(useCase: BasicStageUseCase(), type: .independent)
        return vc
    }()
    private var productView: UIView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addLayouts()
        addConstraints()
        bind()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    private func bind() {
        navBar.leftButtonAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func addLayouts() {
        view.backgroundColor = .white
        addNavBar()
        addProductView()
    }
    
    private func addConstraints() {
        let views: [String: Any] = ["emptySpaceNav": emptySpaceNav, "navBar": navBar, "emptyContent": emptyContent, "productView": productView]
        let matrix: [String: Any] = [:]
        
        var constraints = [NSLayoutConstraint]()
        
        //MARK: emptySpaceNav and emptyContent constraints
        emptySpaceNav.translatesAutoresizingMaskIntoConstraints = false
        emptyContent.translatesAutoresizingMaskIntoConstraints = false
        let vEmptySpaceNavEmptyContent = "V:|-[emptySpaceNav]-1-[emptyContent]-0-|"
        let hEmptySpaceNav = "H:|-0-[emptySpaceNav]-0-|"
        let hEmptyContent = "H:|-0-[emptyContent]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vEmptySpaceNavEmptyContent, options: .alignAllLeading, metrics: matrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hEmptySpaceNav, options: .alignAllTop, metrics: matrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hEmptyContent, options: .alignAllTop, metrics: matrix, views: views)
        constraints += [NSLayoutConstraint(item: emptySpaceNav, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1/9, constant: 0)]
        
        //MARK: navBar constraints
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let hNavBar = "H:|-0-[navBar]-0-|"
        let vNavBar = "V:|-0-[navBar]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vNavBar, options: .alignAllLeading, metrics: matrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hNavBar, options: .alignAllTop, metrics: matrix, views: views)
        
        //MARK: productView constraints
        productView.translatesAutoresizingMaskIntoConstraints = false
        let hProductView = "H:|-0-[productView]-0-|"
        let vProductView = "V:|-0-[productView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vProductView, options: .alignAllLeading, metrics: matrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hProductView, options: .alignAllTop, metrics: matrix, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addNavBar() {
        view.addSubview(emptySpaceNav)
        emptySpaceNav.addSubview(navBar)
        navBar.setLeftButtonText(text: "<-")
        navBar.setTitle(title: "Stage 1")
    }
    
    private func addProductView() {
        view.addSubview(emptyContent)
        productView = productVC.view
        
        addChild(productVC)
        productVC.view.frame = emptyContent.frame
        emptyContent.addSubview(productView)
        productVC.didMove(toParent: self)
    }

}
