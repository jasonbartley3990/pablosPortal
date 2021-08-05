//
//  PurchasedItemsViewController.swift
//  pablosPortalFinal
//
//  Created by Jason bartley on 7/28/21.
//

import UIKit

class PurchasedItemsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(OrderStatusTableViewCell.self, forCellReuseIdentifier: OrderStatusTableViewCell.identifier)
        return table
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "no items purchased or an issue occured in loading."
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.textColor = .label
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private let noItemsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "no items purchased"
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.textColor = .label
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private var orders: [PurchaseOrder] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(errorLabel)
        view.addSubview(noItemsLabel)
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(didPurchase), name: NSNotification.Name("madePurchase"), object: nil)
                                               
        getOrders()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        noItemsLabel.frame = CGRect(x: 10, y: (view.height - 40)/2, width: view.width - 20, height: 40)
        errorLabel.frame = CGRect(x: 10, y: (view.height - 40)/2, width: view.width - 20, height: 50)
    }
    
    @objc func didPurchase() {
        getOrders()
    }
    
    private func getOrders() {
        print("getting orders")
        guard let email = UserDefaults.standard.string(forKey: "email") else {return}
        DatabaseManager.shared.getPurchasedItemsForUser(email: email, completion: {
            [weak self] items, success in
            if success {
                if items.count == 0 {
                    print("zero items")
                    self?.tableView.isHidden = true
                    self?.noItemsLabel.isHidden = false
                } else {
                    print("here")
                    self?.orders = items
                    self?.tableView.reloadData()
                }
            } else {
                print("error")
                self?.errorLabel.isHidden = false
                self?.tableView.isHidden = true
            }
        })
    }
    

    
}

extension PurchasedItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderStatusTableViewCell.identifier, for: indexPath) as? OrderStatusTableViewCell else {
            fatalError()
        }
        cell.configure(with: orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = OrderSummaryViewController(purchase: orders[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
