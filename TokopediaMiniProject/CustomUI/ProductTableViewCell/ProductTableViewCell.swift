//
//  ProductTableViewCell.swift
//  TokopediaMiniProject
//
//  Created by Mac on 16/01/22.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    private let viewLevelOne = UIView()
    private let viewLevelTwo = UIView()
    private let lblNamaProduct = UILabel()
    private let lblJumlahChild = UILabel()
    private let lblChild = UILabel()
    private let viewChildInfo = UIView()
    private let childInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    private let productInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    private var listChild: [Product] = []
    private var uiControll: ProductTableHelper?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        uiControll = ProductCellControll()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setup() {
        setLayout()
        setConstraints()
    }
    
    private func setLayout() {
        self.backgroundColor = .white
        viewLevel()
        addNamaProduct()
        addViewChildInfo()
        addJumlahChild()
        addLabelChild()
        addStackView()
    }
    
    private func setConstraints() {
        let views: [String: Any] = ["viewLevelOne": viewLevelOne, "viewLevelTwo": viewLevelTwo, "lblNamaProduct": lblNamaProduct, "viewChildInfo": viewChildInfo, "lblJumlahChild": lblJumlahChild, "lblChild": lblChild, "childInfoStackView": childInfoStackView, "productInfoStackView": productInfoStackView, "contentStackView": contentStackView]
        let metrix: [String: Any] = [:]
        var constraints = [NSLayoutConstraint]()
        
        //MARK: productInfoStackView constraints
        productInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        let vProductInfoStackViewTblContainer = "V:|-0-[productInfoStackView]-0-|"
        let hProductInfoStackViewTblContainer = "H:|-0-[productInfoStackView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vProductInfoStackViewTblContainer, options: .alignAllLeading, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hProductInfoStackViewTblContainer, options: .alignAllTop, metrics: metrix, views: views)
        constraints += [NSLayoutConstraint(item: productInfoStackView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0)]
        
        //MARK: viewLevelOne and viewLevelTwo constrains
        viewLevelOne.translatesAutoresizingMaskIntoConstraints = false
        viewLevelTwo.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: viewLevelOne, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)]
        constraints += [NSLayoutConstraint(item: viewLevelTwo, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)]
        
        //MARK: childInfoStackView constraints
        childInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        let hChildInfoStackView = "H:|-0-[childInfoStackView]-0-|"
        let vChildInfoStackView = "V:|-0-[childInfoStackView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hChildInfoStackView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vChildInfoStackView, options: .alignAllLeading, metrics: metrix, views: views)
        
        //MARK: viewChildInfo constraints
        viewChildInfo.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: viewChildInfo, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)]
        
        //MARK: lblJumlahChild constraints
        lblJumlahChild.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: lblJumlahChild, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func viewLevel() {
        viewLevelOne.backgroundColor = .white
        contentView.addSubview(viewLevelOne)
        viewLevelTwo.backgroundColor = .white
        contentView.addSubview(viewLevelTwo)
    }

    private func addNamaProduct() {
        lblNamaProduct.textColor = .black
        lblNamaProduct.adjustsFontSizeToFitWidth = true
        lblNamaProduct.text = ""
        contentView.addSubview(lblNamaProduct)
    }
    
    private func addViewChildInfo() {
        viewChildInfo.backgroundColor = .white
        contentView.addSubview(viewChildInfo)
    }
    
    private func addJumlahChild() {
        lblJumlahChild.textColor = .darkGray
        lblJumlahChild.adjustsFontSizeToFitWidth = true
        lblJumlahChild.text = ""
        viewChildInfo.addSubview(lblJumlahChild)
    }
    
    private func addLabelChild() {
        lblChild.textColor = .darkGray
        lblChild.adjustsFontSizeToFitWidth = true
        lblChild.text = "Children"
        viewChildInfo.addSubview(lblChild)
    }
    private func addStackView() {
        childInfoStackView.addArrangedSubview(lblJumlahChild)
        childInfoStackView.addArrangedSubview(lblChild)
        viewChildInfo.addSubview(childInfoStackView)
        productInfoStackView.addArrangedSubview(viewLevelOne)
        productInfoStackView.addArrangedSubview(viewLevelTwo)
        productInfoStackView.addArrangedSubview(lblNamaProduct)
        productInfoStackView.addArrangedSubview(viewChildInfo)
        contentView.addSubview(productInfoStackView)
    }
    
}

extension ProductTableViewCell {
    func setProductInfo(product: Product, searchText: String = "") {
        lblNamaProduct.text = product.name
        lblJumlahChild.text = "\(product.child.count)"
        uiControll?.doValidation(product: product, childInfo: viewChildInfo, spaceLvOne: viewLevelOne, spaceLvTwo: viewLevelTwo)
        listChild = product.child
    }
}
