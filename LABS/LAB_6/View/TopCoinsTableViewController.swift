//
//  RequestViewController.swift
//  LABS
//
//  Created by Погиблов on 07.04.2022.
//

import Foundation
import UIKit

final class TopCoinsTableViewController: ViewController {
    
    private var coins: DataCoin?
    
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    var output: TopCoinsViewPresenter!
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        setupRefreshControl()
        setupTable()
        
        loadDataInTable()
        
    }
    
    private func setupRefreshControl() {
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(updateTableData), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
    }
    
    @objc
    func updateTableData()
    {
        output.reloadData()
    }
    
    private func loadDataInTable() {
        output.loadData()
    }
    
    private func setupHeader(headerTitle: String = "Top crypto coins") {
        let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: 0,
                                   y: 0,
                                   width: tableView.frame.width,
                                   height: 50)
        headerLabel.font = .systemFont(ofSize: 24)
        headerLabel.textAlignment = .center
        headerLabel.text = headerTitle
        tableView.tableHeaderView = headerLabel
    }
    
    override func viewDidLayoutSubviews() {
        setupTableConstraints()
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 70
        
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: "CoinCell")
        
        setupHeader()
    }
    
    private func setupTableConstraints() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension TopCoinsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell") as? CoinTableViewCell
        cell?.configure(coin: coins?.data[indexPath.row])
        return cell!
    }
}

extension TopCoinsTableViewController: UITableViewDelegate {
    
}

// MARK: - TopCoinsViewInput

extension TopCoinsTableViewController: TopCoinsViewInput {
    func reloadData(data: DataCoin) {
        coins = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
}
