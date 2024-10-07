//
//  RMSearchViewModel.swift
//  RickAndMorty
//
//  Created by Doğan Ensar Papuçcuoğlu on 7.10.2024.
//

import Foundation

enum RMSearchResultViewModel {
    case characters([RMCharacterCollectionViewCellViewModel])
    case episodes([RMCharacterEpisodeCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
}
