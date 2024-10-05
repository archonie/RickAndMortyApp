//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Doğan Ensar Papuçcuoğlu on 4.10.2024.
//

import UIKit

final class RMSearchView: UIView {

    private let viewModel: RMSearchViewViewModel
    
    //MARK: - Subviews
    
    //SearchInputView(bar, selection buttons)
    //No results view
    private let noResultsView = RMNoSearchResultsView()
    //Results collectionView
    
    
    //MARK: - Init
    
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(noResultsView)
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            noResultsView.widthAnchor.constraint(equalToConstant: 150),
            noResultsView.heightAnchor.constraint(equalToConstant: 150),
            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
}

//MARK: - CollectionViewDelegate, CollectionViewDataSource

extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
