//
//  StageTwoViewController.swift
//  TokopediaMiniProject
//
//  Created by Mac on 16/01/22.
//

import UIKit

class StageTwoViewController: UIViewController {

    private let navBar = DefaultNavBar()
    private let searchBar = UIView()
    private let emptySpaceNav = UIView()
    private let emptySpaceSearch = UIView()
    private let navBarStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
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
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func addLayouts() {
        view.backgroundColor = .white
        addNavBar()
        addSearchBar()
        addStackView()
        addProductView()
    }

    private func addConstraints() {
        let views: [String: Any] = ["searchBar": searchBar, "navBar": navBar, "emptySpaceNav": emptySpaceNav, "emptySpaceSearch": emptySpaceSearch, "navBarStackView": navBarStackView, "emptyContent": emptyContent, "productView": productView]
        let matrix: [String: Any] = [:]
        
        var constraints = [NSLayoutConstraint]()
        
        //MARK: navBarStackView and emptyContent constraints
        navBarStackView.translatesAutoresizingMaskIntoConstraints = false
        emptyContent.translatesAutoresizingMaskIntoConstraints = false
        let vNavBarStackEmptyContent = "V:|-0-[navBarStackView]-1-[emptyContent]-0-|"
        let hNavBarStack = "H:|-0-[navBarStackView]-0-|"
        let hEmptyContent = "H:|-0-[emptyContent]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vNavBarStackEmptyContent, options: .alignAllLeading, metrics: matrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hNavBarStack, options: .alignAllTop, metrics: matrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hEmptyContent, options: .alignAllTop, metrics: matrix, views: views)
        constraints += [NSLayoutConstraint(item: navBarStackView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 3/9, constant: 0)]
        
        //MARK: navBar constraints
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let hNavBar = "H:|-0-[navBar]-0-|"
        let vNavBar = "V:|-0-[navBar]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vNavBar, options: .alignAllLeading, metrics: matrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hNavBar, options: .alignAllTop, metrics: matrix, views: views)
        
        //MARK: searchBar constraints
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        let hSearchBar = "H:|-0-[searchBar]-0-|"
        let vSearchBar = "V:|-0-[navsearchBarBar]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vSearchBar, options: .alignAllLeading, metrics: matrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hSearchBar, options: .alignAllTop, metrics: matrix, views: views)
        
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
    }
    
    private func addSearchBar() {
        view.addSubview(emptySpaceSearch)
        emptySpaceSearch.addSubview(searchBar)
    }
    
    private func addProductView() {
        view.addSubview(emptyContent)
        productView = productVC.view
        
        addChild(productVC)
        productVC.view.frame = emptyContent.frame
        emptyContent.addSubview(productView)
        productVC.didMove(toParent: self)
    }
    private func addStackView() {
        navBarStackView.addArrangedSubview(emptySpaceNav)
        navBarStackView.addArrangedSubview(emptySpaceSearch)
        view.addSubview(navBarStackView)
    }
    
}
extension StageTwoViewController {
    private func searchKeyword(keyword: String) {
        (productVC as? ListProductViewController)?.doSearchProduct(keyWord: keyword)
    }
}
