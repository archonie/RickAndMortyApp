//
//  RMLocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Doğan Ensar Papuçcuoğlu on 2.10.2024.
//

import UIKit

protocol RMLocationViewViewModelDelegate: AnyObject {
    func didFetchInitialLocations()
    func didSelectLocation(_ location: RMLocation)
    func didLoadMoreLocations(with newIndexPaths: [IndexPath])
    func didUpdateLoadingIndicator(_ isLoading: Bool)
}


final class RMLocationViewViewModel: NSObject{
    
    public weak var delegate: RMLocationView?
    
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
    
    
    
    private var isLoadingMoreLocations = false
    
    //Location response info
    //Will contain next url if present
    private var apiInfo: RMGetAllLocationsResponse.Info?
    public private(set) var cellViewModels: [RMLocationTableViewCellViewModel] = []
    
 
    
    public func locationAtIndex(at index: Int) -> RMLocation? {
        guard index < locations.count, index >= 0 else {
            return nil
        }
        return self.locations[index]
    }
    
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
                print(String(describing: failure))
            }
        }
    }
    
   
    /// Paginate if additional episodes are needed.
    public func fetchAdditionalLocations(url: URL) {
        
        guard !isLoadingMoreLocations else { return }
        isLoadingMoreLocations = true
        
        // Notify the delegate to show the loading indicator
        DispatchQueue.main.async {
            self.delegate?.didUpdateLoadingIndicator(true)
        }
        
        guard let request = RMRequest(url: url) else {
            isLoadingMoreLocations = false
            return
        }
        
        RMService.shared.execute(request, expecting: RMGetAllLocationsResponse.self) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                let info = responseModel.info
                strongSelf.apiInfo = info
                
                let originalCount = strongSelf.locations.count
                let newCount = moreResults.count
                let total = originalCount + newCount
                let startingIndex = total - newCount
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap {
                    return IndexPath(row: $0, section: 0)
                }
                
                strongSelf.locations.append(contentsOf: moreResults)
                
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreLocations(with: indexPathsToAdd)
                    strongSelf.isLoadingMoreLocations = false
                    
                    // Notify the delegate to hide the loading indicator
                    self?.delegate?.didUpdateLoadingIndicator(false)
                }
                
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreLocations = false
            }
        }
    }

    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    
}

//MARK: - ScrollViewDelegate

extension RMLocationViewViewModel: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard shouldShowLoadMoreIndicator, !isLoadingMoreLocations,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height

            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120){
                self?.fetchAdditionalLocations(url: url)
            }
            t.invalidate()
        }
        
        
    }
}

//MARK: - TableViewDelegate

extension RMLocationViewViewModel: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let location = self.locationAtIndex(at: indexPath.row) else {
            return
        }
        delegate?.didSelectLocation(location)
    }
}
    

//MARK: - TableViewDataSource

extension RMLocationViewViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellViewModels = cellViewModels
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RMLocationTableViewCell.cellIdentifier,
            for: indexPath
        ) as? RMLocationTableViewCell else {
            fatalError()
        }
        let cellViewModel = cellViewModels[indexPath.row]
        cell.configure(with: cellViewModel)
        return cell
    }
}



