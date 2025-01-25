//
//  ProductListViewController.swift
//  Youtube MVVM Products
//
//  Created by Yogesh Patel on 23/12/22.
//

import UIKit

class ProductListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: - Variables
    private var viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    @IBAction func addProductButtonTapped(_ sender: UIBarButtonItem) {
        let randomText = "iPhone" + "\(String(Int.random(in: 4...17)))"
        let product = AddProduct(title: randomText)
        viewModel.addProduct(parameters: product)
    }
}
// MARK: - Config & Bind Data
extension ProductListViewController {
    
    func configuration() {
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchProducts()
    }
    
    // Data binding event observe karega - communication
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                startLoading()
            case .stopLoading:
                stopLoading()
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    // UI Main works well
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error ?? "")
            case .newProductAdded(let newProduct):
                print(newProduct)
                self.showAlert(title: "New Product Added", message: "\(newProduct.title) is added")
                
            }
        }
    }
    
    func startLoading(){
        DispatchQueue.main.async {
            /// Indicator show
            print("Product loading....")
            self.activityIndicator.startAnimating()
            self.productTableView.isHidden = true
            self.activityIndicator.isHidden = false
        }
    }
    
    func stopLoading(){
        DispatchQueue.main.async {
            // Indicator hide
            print("Stop loading...")
            self.activityIndicator.stopAnimating()
            self.productTableView.isHidden = false
            self.activityIndicator.isHidden = true
        }
    }
    
}

// MARK: - UITableViewDataSource,UITableViewDelegate
extension ProductListViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsViewController")as! ProductDetailsViewController
        productDetailsVC.productDetailsId = viewModel.products[indexPath.row].id
        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
    
}
