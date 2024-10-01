//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Doğan Ensar Papuçcuoğlu on 30.09.2024.
//

import UIKit

/// Controller to show and search for Characters
final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        view.backgroundColor = .systemBackground
        
        let request = RMRequest(
            endpoint: .character,
            queryParameters: [URLQueryItem(name: "name", value: "rick"), URLQueryItem(name: "status", value: "alive")]
        )
        print(request.url)
        
        RMService.shared.execute(request, expecting: RMCharacter.self) { result in
            
        }
    }
    


}
