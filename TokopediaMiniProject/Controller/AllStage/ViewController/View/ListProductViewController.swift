//
//  ListProductViewController.swift
//  TokopediaMiniProject
//
//  Created by Mac on 16/01/22.
//

import UIKit

class ListProductViewController: UIViewController {
    
    private let loadingSpinner = UIActivityIndicatorView()
    private let loadingView = UIView()
    private let tableContent = UITableView()
    private var typeViewController: VCType?
    private var uiControll: ListUIGuideHelper?
    private var viewModel: ProductVMGuideline?
    private var listExpandProduxt: [[String: String]] = []
    private var productControll: ListProductHelperGuide?
    var sendSelectedValue: ((Product) -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(useCase: StageNetworkProvider, type: VCType) {
        super.init(nibName: nil, bundle: nil)
        viewModel = ProductViewModel(useCase: useCase)
        self.typeViewController = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setLayout()
        setConstraints()
        setupTable()
        uiControll = ListProductUIControll(controller: self)
        productControll = ListProductHelper(controller: self)
        bind()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.loadProduct(reloadTime: 3)
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
        viewModel?.filterResult = { [weak self] _ in
            self?.listExpandProduxt = []
            if let getResult = self?.viewModel?.result {
                self?.productControll?.updateExpandValidation(product: getResult)
            }
            
            self?.tableContent.reloadData()
        }
        viewModel?.productResult = { [weak self] _ in
            self?.listExpandProduxt = []
            self?.uiControll?.hideLoading(completion: nil)
            self?.tableContent.reloadData()
        }
        viewModel?.toggleResult = { [weak self] editedIndex, updateStatus in
            self?.productControll?.cellExpandValidation(listIndex: editedIndex, status: updateStatus)
        }
    }
    
    private func setLayout() {
        view.backgroundColor = .white
        setLoadingView()
        setProductTable()
    }
    
    private func setConstraints() {
        let views: [String: Any] = ["loadingView": loadingView, "tableContent": tableContent, "loadingSpinner": loadingSpinner]
        let metrix: [String: Any] = [:]
        var constraints = [NSLayoutConstraint]()
        
        //MARK: tableContent and loadingView constraints
        tableContent.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        let hTableContent = "H:|-5-[tableContent]-5-|"
        let vTableContentLoadingView = "V:|-[loadingView]-0-[tableContent]-|"
        let hLoadingView = "H:|-0-[loadingView]-0-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hTableContent, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vTableContentLoadingView, options: .alignAllLeading, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hLoadingView, options: .alignAllTop, metrics: metrix, views: views)
        let loadingViewHeight = NSLayoutConstraint(item: loadingView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1/9, constant: 0)
        loadingViewHeight.identifier = "loadingViewHeight"
        constraints += [loadingViewHeight]
        
        //MARK: loadingSpinner constraints
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: loadingSpinner, attribute: .centerX, relatedBy: .equal, toItem: loadingView, attribute: .centerX, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: loadingSpinner, attribute: .centerY, relatedBy: .equal, toItem: loadingView, attribute: .centerY, multiplier: 1, constant: 0)]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    private func setLoadingView() {
        loadingSpinner.color = .gray
        loadingView.addSubview(loadingSpinner)
        loadingSpinner.startAnimating()
        loadingView.backgroundColor = .white
        view.addSubview(loadingView)
    }
    
    private func setProductTable() {
        tableContent.backgroundColor = .white
        view.addSubview(tableContent)
    }
    
    private func setupTable() {
        tableContent.delegate = self
        tableContent.dataSource = self
        tableContent.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductCell")
        tableContent.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableContent.tableFooterView = UIView()
    }
    
}
extension ListProductViewController {
    
    func getLoadingView() -> UIView {
        return loadingView
    }
    
    func getLoadingSpinner() -> UIActivityIndicatorView {
        return loadingSpinner
    }
    
    func doSearchProduct(keyWord: String) {
        viewModel?.searchProduct(keyword: keyWord)
    }
    
    fileprivate func getListExpandProduxt() -> [[String: String]] {
        return listExpandProduxt
    }
    
    fileprivate func updateListExpandProduxt(id: String, root: String) {
        listExpandProduxt.append(["id": id, "root": root])
    }
    
    fileprivate func getTableContent() -> UITableView {
        return tableContent
    }
    
    fileprivate func expandProduct(product: Product) {
        viewModel?.expandProduct(child: product.child)
    }
    
    fileprivate func hideSpesificProduct(product: Product) {
        viewModel?.hideSpesificProduct(child: product.child)
    }
    
    fileprivate func hideAllProduct(id: String) {
        viewModel?.hideAllProduct(id: id)
    }
    
    fileprivate func removeSelectedlistExpandProduxt(index: Int) {
        listExpandProduxt.remove(at: index)
    }
    
    fileprivate func removeAllListExpandProduct(id: String) {
        listExpandProduxt.removeAll(where: {$0["root"] == id})
    }
    
}
extension ListProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.result.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let getProductInfo = viewModel?.result[indexPath.row], let typeVC = typeViewController {
            return productControll?.cellDisplayControll(tableView: tableView, type: typeVC, indexPath: indexPath, product: getProductInfo) ?? UITableViewCell()
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let getViewModel = self.viewModel, let typeVC = typeViewController {
            productControll?.selectValidation(product: getViewModel.result[indexPath.row], type: typeVC)
            
        }
    }

}

fileprivate class ListProductHelper {
    private var controller: UIViewController?
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
}

extension ListProductHelper: ListProductHelperGuide {
    func cellExpandValidation(listIndex: [Int], status: Bool) {
        
        var getlListIndex: [IndexPath] = []
        if status == true {
            getlListIndex = listIndex.map({ (getIndex) -> IndexPath in
                return IndexPath(row: getIndex, section: 0)
            })
            (self.controller as? ListProductViewController)?.getTableContent().beginUpdates()
            (self.controller as? ListProductViewController)?.getTableContent().insertRows(at: getlListIndex, with: .automatic)
            (self.controller as? ListProductViewController)?.getTableContent().endUpdates()

        } else {
            getlListIndex = listIndex.map({ (getIndex) -> IndexPath in
                return IndexPath(row: getIndex, section: 0)
            })
            (self.controller as? ListProductViewController)?.getTableContent().beginUpdates()
            (self.controller as? ListProductViewController)?.getTableContent().deleteRows(at: getlListIndex, with: .automatic)
            (self.controller as? ListProductViewController)?.getTableContent().endUpdates()
        }
        
    }
    
    func updateExpandValidation(product: [Product]) {
        for getExpanded in product {
            (self.controller as? ListProductViewController)?.updateListExpandProduxt(id: getExpanded.id, root: getExpanded.root)
        }
    }
    
    func cellDisplayControll(tableView: UITableView, type: VCType, indexPath: IndexPath, product: Product) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        cell.setProductInfo(product: product)
        
        return cell
    }
    
    func selectValidation(product: Product, type: VCType) {
        guard let _controller = self.controller as? ListProductViewController else {
            return
        }
        
        if product.child.count != 0 {
            if _controller.getListExpandProduxt().firstIndex(where: { $0["id"] == product.id && $0["root"] == product.root }) == nil {
                _controller.expandProduct(product: product)
                _controller.updateListExpandProduxt(id: product.id, root: product.root)
            } else {
                if product.root != "" {
                    
                    if let index = _controller.getListExpandProduxt().firstIndex(where: { $0["id"] == product.id && $0["root"] == product.root }) {
                        _controller.hideSpesificProduct(product: product)
                        _controller.removeSelectedlistExpandProduxt(index: index)
                    }
                } else {
                    if let index = _controller.getListExpandProduxt().firstIndex(where: { $0["id"] == product.id && $0["root"] == "" }) {
                        _controller.hideAllProduct(id: product.id)
                        _controller.removeAllListExpandProduct(id: product.id)
                        _controller.removeSelectedlistExpandProduxt(index: index)
                    }
                }
            }
        } else {
            
            if type != .popup {
                print("not reload")
            } else {
                _controller.dismiss(animated: true, completion: {
                    _controller.sendSelectedValue?(product)
                })
            }
        }
    }
}
