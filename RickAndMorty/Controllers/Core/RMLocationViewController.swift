//
//  RMLocationViewController.swift
//  RickAndMorty
//
//  Created by Doğan Ensar Papuçcuoğlu on 30.09.2024.
//

import UIKit

/// Controller to show and search for Locations
final class RMLocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Locations"
        view.backgroundColor = .systemBackground
        addSearchButton()

    }
    
    private func addSearchButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc
    private func didTapSearch(){
        
    }


}
