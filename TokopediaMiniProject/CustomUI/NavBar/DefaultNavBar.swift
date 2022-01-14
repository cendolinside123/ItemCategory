//
//  DefaultNavBar.swift
//  TokopediaMiniProject
//
//  Created by Mac on 14/01/22.
//

import UIKit

class DefaultNavBar: UIView {
    
    private let leftButton = UIButton()
    private let contentView = UIView()
    private let titleLabel = UILabel()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var leftButtonAction: (() -> Void)?
    var isLeftButtonHidden: Bool = false {
        didSet {
            leftButton.isHidden = isLeftButtonHidden
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        addLayout()
        addConstraints()
    }
    
    private func addLayout() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        addContentView()
        addLeftButton()
        addTitleLabel()
    }
    
    private func addConstraints() {
        let views = ["contentView": contentView, "leftButton": leftButton, "titleLabel": titleLabel]
        let metrix: [String: Any] = [:]
        var constraints = [NSLayoutConstraint]()
        
        
        //MARK: contentView constrains
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let hContentView = "H:|-0-[contentView]-0-|"
        let vContentView = "V:|-0-[contentView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContentView, options: .alignAllCenterY, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContentView, options: .alignAllCenterX, metrics: metrix, views: views)
        
        //MARK: leftButton constrains
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        let vLeftButton = "V:|-[leftButton]-|"
        constraints += [NSLayoutConstraint(item: leftButton, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 5)]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vLeftButton, options: .alignAllLeading, metrics: metrix, views: views)
        
        
        //MARK: titleLabel constrains
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let vTitleLabel = "V:|-[titleLabel]-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vTitleLabel, options: .alignAllCenterX, metrics: metrix, views: views)
        constraints += [NSLayoutConstraint(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: 3/9, constant: 0)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addContentView() {
        self.addSubview(contentView)
        contentView.backgroundColor = .white
    }
    
    private func addLeftButton() {
        contentView.addSubview(leftButton)
        leftButton.backgroundColor = .white
        leftButton.titleLabel?.adjustsFontSizeToFitWidth = true
        setLeftButtonText(text: "-")
        leftButton.setTitleColor(.black, for: .normal)
    }
    
    private func addTitleLabel() {
        titleLabel.text = ""
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(titleLabel)
    }
    
    private func setButtonFunctionality() {
        leftButton.addTarget(self, action: #selector(leftButtonTap), for: .touchDown)
    }

}
extension DefaultNavBar {
    func setLeftButtonText(text: String) {
        leftButton.setTitle(text, for: .normal)
    }
    
    func setBorderColor(color: UIColor) {
        self.layer.borderColor = color.cgColor
    }
    
    func setBorderWidth(width: CGFloat) {
        self.layer.borderWidth = width
    }
    
    @objc private func leftButtonTap() {
        leftButtonAction?()
    }
    
}
