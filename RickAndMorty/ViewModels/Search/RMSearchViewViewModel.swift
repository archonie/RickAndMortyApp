//
//  RMSearchViewViewModel.swift
//  RickAndMorty
//
//  Created by Doğan Ensar Papuçcuoğlu on 4.10.2024.
//

import Foundation

//Responsibilities
// - Show search results
// - Show no results view
// - Kick off API requests

final class RMSearchViewViewModel {
    
    let config: RMSearchViewController.Config
    
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
}
