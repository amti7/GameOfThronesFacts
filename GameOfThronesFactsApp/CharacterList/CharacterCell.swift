//
//  CharacterCell.swift
//  GameOfThronesFactsApp
//
//  Created by Kamil on 28/09/2020.
//  Copyright © 2020 Kamil Gacek. All rights reserved.
//

import UIKit
import LBTAComponents
import TinyConstraints

class CharacterCell: UITableViewCell {
    
    private let characterImageView = CachedImageView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with character: Character) {
        
        characterImageView.loadImage(urlString: character.thumbnail)
        nameLabel.text = character.title
        descriptionLabel.text = character.abstract
    }
    
    private func addSubviews() {
        [characterImageView, nameLabel, descriptionLabel].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        characterImageView.leadingToSuperview(offset: 16)
        characterImageView.centerYToSuperview()
        
        nameLabel.top(to: characterImageView, offset: 4)
        nameLabel.leadingToTrailing(of: characterImageView, offset: 16)
        nameLabel.trailingToSuperview(offset: 16)
        
        descriptionLabel.topToBottom(of: nameLabel, offset: 8)
        descriptionLabel.leadingToTrailing(of: characterImageView, offset: 16)
        descriptionLabel.trailingToSuperview(offset: 16)
    }
    
    private func setupSubviews() {
        characterImageView.size(CGSize(width: 68, height: 68))
        characterImageView.layer.cornerRadius = 32

        nameLabel.font = .boldSystemFont(ofSize: 16)
        
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 2
    }
    
    
}
