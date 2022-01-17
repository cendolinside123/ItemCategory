//
//  SearchBar.swift
//  TokopediaMiniProject
//
//  Created by Mac on 16/01/22.
//

import UIKit

class SearchBar: UIView {
    private let searchBox = UITextField()
    private let contentView = UIView()
    var searchText: ((String) -> Void)?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        searchBox.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        addLayouts()
        addContentView()
        addConstraints()
    }
    
    private func addLayouts() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        addContentView()
        addSearchBox()
    }
    
    private func addConstraints() {
        let views: [String: Any] = ["contentView": contentView, "searchBox": searchBox]
        let matrix: [String: Any] = [:]
        var constraints = [NSLayoutConstraint]()
        
        //MARK: contentView constrains
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let hContentView = "H:|-0-[contentView]-0-|"
        let vContentView = "V:|-0-[contentView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContentView, options: .alignAllCenterY, metrics: matrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContentView, options: .alignAllCenterX, metrics: matrix, views: views)
        
        //MARK: searchBox constrains
        searchBox.translatesAutoresizingMaskIntoConstraints = false
        let hSearchBox = "H:|-5-[searchBox]-5-|"
        let vSearchBox = "V:|-1-[searchBox]-1-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hSearchBox, options: .alignAllCenterY, metrics: matrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vSearchBox, options: .alignAllCenterX, metrics: matrix, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addContentView() {
        self.addSubview(contentView)
        contentView.backgroundColor = .white
    }
    
    private func addSearchBox() {
        contentView.addSubview(searchBox)
        searchBox.clearButtonMode = .always
        searchBox.placeholder = "Search Product"
        searchBox.backgroundColor = .white
        searchBox.layer.borderColor = UIColor.black.cgColor
        searchBox.layer.borderWidth = 1
        searchBox.textColor = .black
        searchBox.delegate = self
    }

}
extension SearchBar {
    func setBorderColor(color: UIColor) {
        self.layer.borderColor = color.cgColor
    }
    
    func setBorderWidth(width: CGFloat) {
        self.layer.borderWidth = width
    }
}

extension SearchBar: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == searchBox {
            searchText?(textField.text ?? "")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    
}


