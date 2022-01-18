//
//  ProductCollectionViewCell.swift
//  TokopediaMiniProject
//
//  Created by Mac on 18/01/22.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    private let imageProduct = UIImageView()
    private let lblTitle = UILabel()
    private let stackViewContent:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        self.backgroundColor = .white
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        addLayouts()
        addConstraints()
    }
    
    private func addLayouts() {
        addImage()
        addTitle()
        addStackView()
    }
    
    private func addConstraints() {
        let views = ["stackViewContent": stackViewContent, "imageProduct": imageProduct, "lblTitle": lblTitle]
        let metrix:[String:Any] = [:]
        
        var constraints = [NSLayoutConstraint]()
        
        //MARK: stackViewContent constraints
        stackViewContent.translatesAutoresizingMaskIntoConstraints = false
        let hStackViewContent = "H:|-0-[stackViewContent]-0-|"
        let vStackViewContent = "V:|-0-[stackViewContent]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hStackViewContent, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vStackViewContent, options: .alignAllLeading, metrics: metrix, views: views)
        
        //MARK: lblTitle and imageProduct constraints
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        imageProduct.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: lblTitle, attribute: .height, relatedBy: .equal, toItem: imageProduct, attribute: .height, multiplier: 3/7, constant: 0)]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addImage() {
        imageProduct.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
        imageProduct.image = #imageLiteral(resourceName: "shop")
        contentView.addSubview(imageProduct)
    }
    
    private func addTitle() {
        lblTitle.font = UIFont.boldSystemFont(ofSize: 20)
        lblTitle.numberOfLines = 0
        lblTitle.lineBreakMode = .byTruncatingTail
        lblTitle.adjustsFontSizeToFitWidth = true
        lblTitle.textColor = .black
        lblTitle.backgroundColor = .white
        contentView.addSubview(lblTitle)
    }
    
    private func addStackView() {
        stackViewContent.addArrangedSubview(imageProduct)
        stackViewContent.addArrangedSubview(lblTitle)
        contentView.addSubview(stackViewContent)
    }
}

extension ProductCollectionViewCell {
    func setProduct(product: Product) {
        lblTitle.text = product.name
        imageProduct.setImage(url: product.iconImageUrl)
    }
    
    func getImage() -> UIImageView {
        return imageProduct
    }
    
}
