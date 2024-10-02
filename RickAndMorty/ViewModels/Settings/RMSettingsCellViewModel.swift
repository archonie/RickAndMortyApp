//
//  RMSettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by Doğan Ensar Papuçcuoğlu on 2.10.2024.
//

import UIKit

struct RMSettingsCellViewModel: Identifiable{
   
    let id = UUID()
       
    public let type: RMSettingsOption
    public let onTapHandler: (RMSettingsOption) -> Void
    
    
    //MARK: - Init
    
    init(type: RMSettingsOption, onTapHandler: @escaping (RMSettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
    }
    
    
    //MARK: - Public

    public var image: UIImage? {
        return type.iconImage
    }
    public var title: String {
        type.displayTitle
    }
    public var containerColor: UIColor {
        type.iconContainerColor
    }
    
}
