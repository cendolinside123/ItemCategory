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
    private var productControll: ListProductHelperGuide?
    var sendSelectedValue: ((Product) -> Void)?
    private var selectedText: String = ""
    
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
        productControll = ListProductHelper()
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
            self?.tableContent.reloadData()
        }
        viewModel?.productResult = { [weak self] _ in
            self?.uiControll?.hideLoading(completion: nil)
            self?.tableContent.reloadData()
        }
        viewModel?.toggleResult = { [weak self] editedIndex, updateStatus in
            if let getTabel = self?.tableContent {
                self?.productControll?.cellExpandValidation(listIndex: editedIndex, status: updateStatus, tableView: getTabel)
            }
        }
        viewModel?.sendaProduct = { [weak self] selectedProduct in
            self?.dismiss(animated: true, completion: {
                self?.sendSelectedValue?(selectedProduct)
            })
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
        selectedText = keyWord
        viewModel?.searchProduct(keyword: keyWord)
    }
    
}
extension ListProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.result.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let getProductInfo = viewModel?.result[indexPath.row], let typeVC = typeViewController {
            return productControll?.cellDisplayControll(tableView: tableView, type: typeVC, indexPath: indexPath, product: getProductInfo, selectedText: selectedText) ?? UITableViewCell()
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let getViewModel = self.viewModel, let typeVC = typeViewController {
            return productControll?.cellHighControll(type: typeVC, product: getViewModel.result[indexPath.row]) ?? 50
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let getViewModel = self.viewModel, let typeVC = typeViewController {
            getViewModel.selectExpandProduct(product: getViewModel.result[indexPath.row], type: typeVC)
        }
    }

}

fileprivate class ListProductHelper {
    init() {
    }
    
}

extension ListProductHelper: ListProductHelperGuide {
    func cellHighControll(type: VCType, product: Product) -> CGFloat {
        if type == .independentV2 && product.level == 2 {
            return 150
        } else {
            return 50
        }
    }
    
    
    func cellExpandValidation(listIndex: [Int], status: Bool, tableView: UITableView) {
        
        var getlListIndex: [IndexPath] = []
        if status == true {
            getlListIndex = listIndex.map({ (getIndex) -> IndexPath in
                return IndexPath(row: getIndex, section: 0)
            })
            tableView.beginUpdates()
            tableView.insertRows(at: getlListIndex, with: .automatic)
            tableView.endUpdates()

        } else {
            getlListIndex = listIndex.map({ (getIndex) -> IndexPath in
                return IndexPath(row: getIndex, section: 0)
            })
            tableView.beginUpdates()
            tableView.deleteRows(at: getlListIndex, with: .automatic)
            tableView.endUpdates()
        }
        
    }
    
    func cellDisplayControll(tableView: UITableView, type: VCType, indexPath: IndexPath, product: Product, selectedText: String) -> UITableViewCell {
        
        if type == .independentV2 && product.level == 2 {
            return UITableViewCell()
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            
            cell.setProductInfo(product: product, searchText: selectedText)
            
            return cell
        }
    }
}
