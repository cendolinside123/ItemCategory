//
//  StageThreeViewController.swift
//  TokopediaMiniProject
//
//  Created by Mac on 18/01/22.
//

import UIKit

class StageThreeViewController: UIViewController {

    private let navBar = DefaultNavBar()
    private let emptySpaceNav = UIView()
    private let popUpButton = UIButton()
    private let lblTitle = UILabel()
    private let lblSelectedProduct = UILabel()
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addLayout()
        addConstraints()
        addButtonSetup()
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
    
    private func bind() {
        navBar.leftButtonAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func addLayout() {
        self.view.backgroundColor = .white
        addNavBar()
        addLblTitle()
        addLblSelectedProduct()
        addPopUpButton()
        addStackView()
    }
    
    private func addConstraints() {
        let views: [String: Any] = ["navBar": navBar ,"emptySpaceNav": emptySpaceNav, "lblTitle": lblTitle, "lblSelectedProduct": lblSelectedProduct, "popUpButton": popUpButton, "contentStackView": contentStackView]
        let metrix: [String: Any] = [:]
        var constraints: [NSLayoutConstraint] = []
        
        //MARK: contentStackView, emptySpaceNav, and popUpButton constraints
        emptySpaceNav.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        popUpButton.translatesAutoresizingMaskIntoConstraints = false
        let hContentStackView = "H:|-5-[contentStackView]-5-|"
        let hEmptySpaceNav = "H:|-0-[emptySpaceNav]-0-|"
        let vContentStackView = "V:|-[emptySpaceNav]-5-[contentStackView]-15-[popUpButton]|"
        let hPopUpButton = "H:|-5-[popUpButton]|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContentStackView, options: .alignAllLeading, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hEmptySpaceNav, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContentStackView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hPopUpButton, options: .alignAllTop, metrics: metrix, views: views)
        
        constraints += [NSLayoutConstraint(item: emptySpaceNav, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1/9, constant: 0)]
        constraints += [NSLayoutConstraint(item: contentStackView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 2.5/9, constant: 0)]
        constraints += [NSLayoutConstraint(item: popUpButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)]
        constraints += [NSLayoutConstraint(item: popUpButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 10)]
        
        //MARK: navBar constraints
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let hNavBar = "H:|-0-[navBar]-0-|"
        let vNavBar = "V:|-0-[navBar]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vNavBar, options: .alignAllLeading, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hNavBar, options: .alignAllTop, metrics: metrix, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addNavBar() {
        view.addSubview(emptySpaceNav)
        emptySpaceNav.addSubview(navBar)
        navBar.setLeftButtonText(text: "<-")
        navBar.setTitle(title: "Stage 3")
    }
    
    private func addLblTitle() {
        lblTitle.textColor = .black
        lblTitle.adjustsFontSizeToFitWidth = true
        lblTitle.text = "You Have no selected category"
        lblTitle.numberOfLines = 0
        lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(lblTitle)
    }
    
    private func addLblSelectedProduct() {
        lblSelectedProduct.textColor = .black
        lblSelectedProduct.adjustsFontSizeToFitWidth = true
        lblSelectedProduct.text = ""
        view.addSubview(lblSelectedProduct)
    }
    
    private func addPopUpButton() {
        popUpButton.setTitle("Choose One", for: .normal)
        popUpButton.setTitleColor(.blue, for: .normal)
        view.addSubview(popUpButton)
    }

    private func addStackView() {
        contentStackView.addArrangedSubview(lblTitle)
        contentStackView.addArrangedSubview(lblSelectedProduct)
        view.addSubview(contentStackView)
    }
    
    private func addButtonSetup() {
        popUpButton.addTarget(self, action: #selector(popUpAction), for: .touchDown)
    }
    
}
extension StageThreeViewController {
    @objc private func popUpAction() {
        let popUpVC = PopUpViewController()
        popUpVC.getSelectedResult = { [weak self] result in
            self?.lblTitle.text = "You have choose"
            self?.lblSelectedProduct.text = result.name
        }
        self.present(popUpVC, animated: true, completion: nil)
    }
}
