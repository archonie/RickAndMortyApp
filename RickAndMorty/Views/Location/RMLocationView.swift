//
//  RMLocationView.swift
//  RickAndMorty
//
//  Created by Doğan Ensar Papuçcuoğlu on 2.10.2024.
//

import UIKit

protocol RMLocationViewDelegate: AnyObject {
    func rmLocationView(_ locationView: RMLocationView, didSelect location: RMLocation)
}




final class RMLocationView: UIView {
    
    public weak var delegate: RMLocationViewController?
    
    private var viewModel = RMLocationViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    

    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.alpha = 0
        table.isHidden = true
        table.register(RMLocationTableViewCell.self,
                       forCellReuseIdentifier: RMLocationTableViewCell.cellIdentifier)
        table.register(RMFooterLoadingTableFooterView.self, forHeaderFooterViewReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        return table
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(tableView, spinner)
        viewModel.delegate = self
        viewModel.fetchLocations()
        spinner.startAnimating()
        addConstraints()
        configureTable()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    private func configureTable() {
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
  
}





extension RMLocationView: RMLocationViewViewModelDelegate {
    
    
    func didSelectLocation(_ location: RMLocation) {
        delegate?.rmLocationView(self, didSelect: location)
    }
   
    func didFetchInitialLocations() {
        spinner.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData() //Initial fetch
        UIView.animate(withDuration: 0.4) {
            self.tableView.alpha = 1
        }
    }
    
    func didLoadMoreLocations(with newIndexPaths: [IndexPath]) {
        tableView.performBatchUpdates {
            self.tableView.insertRows(at: newIndexPaths, with: UITableView.RowAnimation.fade)
        }
    }
    
    func didUpdateLoadingIndicator(_ isLoading: Bool) {
        if isLoading {
            let footerView = RMFooterLoadingTableFooterView(reuseIdentifier: RMFooterLoadingTableFooterView.identifier)
            tableView.tableFooterView = footerView
            footerView.startAnimating()
        } else {
            tableView.tableFooterView = nil
        }
    }
    
    
}
