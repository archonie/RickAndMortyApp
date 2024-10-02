//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Doğan Ensar Papuçcuoğlu on 2.10.2024.
//

import UIKit

protocol RMEpisodeDetailViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}



final class RMEpisodeDetailViewViewModel {
    
    private let endpointUrl: URL?
    private var dataTuple: (RMEpisode, [RMCharacter])? {
        didSet {
            delegate?.didFetchEpisodeDetails()
        }
    }
    
    enum SectionType {
        case information(viewModel: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharacterCollectionViewCellViewModel])
        
    }
    
    public weak var delegate: RMEpisodeDetailViewViewModelDelegate?
    
    public private(set) var sections: [SectionType] = []
   
    
    //MARK: - Init
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
    }
    
    //MARK: - Public
    
    
    
    
    //MARK: - Private
    
    /// Fetch backing episode model
    public func fetchEpisodeData() {
        
        guard let url = endpointUrl, let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(episode: model)
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
    private func fetchRelatedCharacters(episode: RMEpisode) {
        /// Gets the urls as string from the episode and converts them to urls first after that creates requests with that urls
        let requests: [RMRequest] = episode.characters.compactMap({
            return URL(string: $0)
        }).compactMap({
            return RMRequest(url: $0)
        })
        
        let group = DispatchGroup()
        var characters: [RMCharacter] = []
        
        for request in requests {
            group.enter()
            RMService.shared.execute(request, expecting: RMCharacter.self) { result in

                //Defer means last thing to run for this iteration
                defer {
                    group.leave()
                }
                
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure(let failure):
                    break
                }
            }
        }
        group.notify(queue: .main) {
            self.dataTuple = (
                episode,
                characters
            )
        }
        
    }
}
