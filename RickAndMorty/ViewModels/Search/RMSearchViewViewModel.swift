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
    private var optionMap: [RMSearchInputViewViewModel.DynamicOption: String] = [:]
    private var searchText = ""
    private var optionMapUpdateBlock: (((RMSearchInputViewViewModel.DynamicOption, String)) -> Void)?
    
    //MARK: - Init
    
    init(config: RMSearchViewController.Config) {
        self.config = config
        
    }
    
    
    //MARK: - Public
    
    public func executeSearch() {
        // Create request based on filters
        // Send API Call
        // Notify view of results, no results or error
        
    }
    
    public func set(query text: String) {
        self.searchText = text
        print(self.searchText)
    }
    
    public func set(value: String, for option: RMSearchInputViewViewModel.DynamicOption) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func registerOptionChangeBlock(_ block: @escaping ((RMSearchInputViewViewModel.DynamicOption, String)) -> Void) {
        self.optionMapUpdateBlock = block
    }
}
