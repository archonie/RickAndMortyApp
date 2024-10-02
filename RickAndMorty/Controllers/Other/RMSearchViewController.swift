//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Doğan Ensar Papuçcuoğlu on 2.10.2024.
//

import UIKit

/// Configurable controller to search
class RMSearchViewController: UIViewController {
    
    struct Config {
        
        enum ConfigType {
            case character
            case episode
            case location
         }
        
        let type: ConfigType
    }
    
    
    private let config: Config
    
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = .systemBackground
    }
    

    

}
