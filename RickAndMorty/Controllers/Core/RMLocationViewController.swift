//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Doğan Ensar Papuçcuoğlu on 30.09.2024.
//

import UIKit

/// Controller to show and search for Locations
final class RMLocationViewController: UIViewController, RMLocationViewDelegate {
    

    private let primaryView = RMLocationView()
    private let viewModel = RMLocationViewViewModel()
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        primaryView.delegate = self
        view.addSubview(primaryView)
        title = "Locations"
        view.backgroundColor = .systemBackground
        addSearchButton()
        addConstraints()
        viewModel.fetchLocations()
    }
    
    //MARK: - Private
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    private func addSearchButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc
    private func didTapSearch(){
        let vc = RMSearchViewController(config: .init(type: .location))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - LocationView Delegate
    
    func rmLocationView(_ locationView: RMLocationView, didSelect location: RMLocation) {
        let locationVC = RMLocationDetailViewController(location: location)
        locationVC.title = location.name
        locationVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(locationVC, animated: true)
    }
    

    
    
}

