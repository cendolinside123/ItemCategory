//
//  ProductV2TableViewCell.swift
//  TokopediaMiniProject
//
//  Created by Mac on 19/01/22.
//

import UIKit

class ProductV2TableViewCell: UITableViewCell {
    private let emptySpace = UIView()
    private var collectionItem:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)

        return collection
    }()
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()

    
    private var listChild: [Product] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSetup()
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
    
    private func setupCollectionView() {
        collectionItem.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        collectionItem.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductColectionViewCell")
        collectionItem.delegate = self
        collectionItem.dataSource = self
    }
    
    
    private func addSetup() {
        self.backgroundColor = .white
        addLayout()
        addConstraint()
        setupCollectionView()
    }
    
    private func addLayout() {
        addEmptyView()
        addCollectionItem()
        addStackView()
    }
    
    private func addConstraint() {
        let views: [String: Any] = ["emptySpace": emptySpace, "collectionItem": collectionItem, "contentStackView": contentStackView]
        let matrix: [String: Any] = [:]
        
        var constraits: [NSLayoutConstraint] = []
        
        //MARK: contentStackView constraints
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        let vContentStackView = "V:|-0-[contentStackView]-0-|"
        let hContentStackView = "H:|-0-[contentStackView]-0-|"
        constraits += NSLayoutConstraint.constraints(withVisualFormat: vContentStackView, options: .alignAllLeading, metrics: matrix, views: views)
        constraits += NSLayoutConstraint.constraints(withVisualFormat: hContentStackView, options: .alignAllTop, metrics: matrix, views: views)
        
        //MARK: emptySpace constraints
        emptySpace.translatesAutoresizingMaskIntoConstraints = false
        constraits += [NSLayoutConstraint(item: emptySpace, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)]
        
        NSLayoutConstraint.activate(constraits)
    }
    
    private func addEmptyView() {
        emptySpace.backgroundColor = .white
        contentView.addSubview(emptySpace)
    }
    
    private func addCollectionItem() {
        collectionItem.backgroundColor = .white
        contentView.addSubview(collectionItem)
    }
    
    private func addStackView() {
        contentStackView.addArrangedSubview(emptySpace)
        contentStackView.addArrangedSubview(collectionItem)
        contentView.addSubview(contentStackView)
    }

}

extension ProductV2TableViewCell {
    func setupData(dummyProduct: Product) {
        listChild = dummyProduct.child
        collectionItem.reloadData()
    }
}

extension ProductV2TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listChild.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductColectionViewCell", for: indexPath) as? ProductCollectionViewCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
        }
        cell.setProduct(product: listChild[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductColectionViewCell", for: indexPath) as? ProductCollectionViewCell else {
            return
        }
        cell.getImage().kf.cancelDownloadTask()
        cell.getImage().image = nil
    }
    
}
extension ProductV2TableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width) / 2
        
        return CGSize(width: Int(width), height: Int(collectionView.bounds.height))
    }
}

