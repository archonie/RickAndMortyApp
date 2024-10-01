//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Doğan Ensar Papuçcuoğlu on 1.10.2024.
//

import UIKit

/// VC to show details about single episode
final class RMEpisodeDetailViewController: UIViewController {

    private let url: URL?
    
    
    //MARK: - Init
    
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Lifecycyle 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Episode"
        view.backgroundColor = .systemRed
    }
    

  

}
