//
//  RMLocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Doğan Ensar Papuçcuoğlu on 2.10.2024.
//

import Foundation

protocol RMLocationViewViewModelDelegate: AnyObject {
    func didFetchInitialLocations()
}


final class RMLocationViewViewModel {
    
    private var locations: [RMLocation] = [] {
        didSet{
            for location in locations {
                let cellViewModel = RMLocationTableViewCellViewModel(location: location)
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
    weak var delegate: RMLocationViewViewModelDelegate?
    
    //Location response info
    //Will contain next url if present
    private var apiInfo: RMGetAllLocationsResponse.Info?
    public private(set) var cellViewModels: [RMLocationTableViewCellViewModel] = []
    
    init() {}
    
    public func fetchLocations() {
        RMService.shared.execute(
            .listLocationRequest,
            expecting: RMGetAllLocationsResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let model):
                self?.apiInfo = model.info
                self?.locations = model.results
                DispatchQueue.main.async {
                    self?.delegate?.didFetchInitialLocations()
                }
            case .failure(let failure):
                break
            }
        }
    }
    
    private var hasMoreResults: Bool {
        return false
    }
    
    
}
