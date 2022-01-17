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
        bind()
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
                
                for getExpanded in getResult {
                    self?.listExpandProduxt.append(["id": getExpanded.id, "root": getExpanded.root])
                }
            }
            
            self?.tableContent.reloadData()
        }
        viewModel?.productResult = { [weak self] _ in
            self?.listExpandProduxt = []
            self?.uiControll?.hideLoading(completion: nil)
            self?.tableContent.reloadData()
        }
        viewModel?.toggleResult = { [weak self] editedIndex, updateStatus in
            var listIndex: [IndexPath] = []
            if updateStatus == true {
                listIndex = editedIndex.map({ (getIndex) -> IndexPath in
                    return IndexPath(row: getIndex, section: 0)
                })
                self?.tableContent.beginUpdates()
                self?.tableContent.insertRows(at: listIndex, with: .automatic)
                self?.tableContent.endUpdates()

            } else {
                listIndex = editedIndex.map({ (getIndex) -> IndexPath in
                    return IndexPath(row: getIndex, section: 0)
                })
                self?.tableContent.beginUpdates()
                self?.tableContent.deleteRows(at: listIndex, with: .automatic)
                self?.tableContent.endUpdates()
            }
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
    
}
extension ListProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.result.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        if let getProductInfo = viewModel?.result[indexPath.row] {
            cell.setProductInfo(product: getProductInfo)
        } else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let getViewModel = self.viewModel {
            if getViewModel.result[indexPath.row].child.count != 0 {
                
                
                if listExpandProduxt.firstIndex(where: { $0["id"] == getViewModel.result[indexPath.row].id && $0["root"] == getViewModel.result[indexPath.row].root }) == nil {
                    self.viewModel?.expandProduct(child: getViewModel.result[indexPath.row].child)
                    listExpandProduxt.append(["id": getViewModel.result[indexPath.row].id, "root": getViewModel.result[indexPath.row].root])
                } else {
                    if getViewModel.result[indexPath.row].root != "" {
                        getViewModel.hideSpesificProduct(child: getViewModel.result[indexPath.row].child)
                        listExpandProduxt.remove(at: listExpandProduxt.firstIndex(where: { $0["id"] == getViewModel.result[indexPath.row].id && $0["root"] == getViewModel.result[indexPath.row].root })!)
                    } else {
                        getViewModel.hideAllProduct(id: getViewModel.result[indexPath.row].id)
                        listExpandProduxt.removeAll(where: {$0["root"] == getViewModel.result[indexPath.row].id})
                        listExpandProduxt.remove(at: listExpandProduxt.firstIndex(where: { $0["id"] == getViewModel.result[indexPath.row].id && $0["root"] == "" })!)
                    }
                    
                }
                
            } else {
                print("not reload")
            }
            
        }
        
    }
    
}

