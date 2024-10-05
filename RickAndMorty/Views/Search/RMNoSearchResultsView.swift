//
//  RMNoSearchResultsView.swift
//  RickAndMorty
//
//  Created by Doğan Ensar Papuçcuoğlu on 4.10.2024.
//

import UIKit

final class RMNoSearchResultsView: UIView {
    
    private let viewModel = RMNoSearchResultsViewViewModel()

    private let iconView: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .systemBlue
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(iconView, titleLabel)
        addConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 90),
            iconView.heightAnchor.constraint(equalToConstant: 90),
            iconView.topAnchor.constraint(equalTo: topAnchor),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),
            
        ])
    }
    
    private func configure(){
        titleLabel.text = viewModel.title
        iconView.image = viewModel.image
    }
    
}
