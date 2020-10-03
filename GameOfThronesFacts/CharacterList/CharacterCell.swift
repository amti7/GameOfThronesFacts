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
    
    private struct Constants {
        static let smallerOffset: CGFloat = 8
        static let standardOffset: CGFloat = 16
        static let descriptionFont: CGFloat = 15
        static let cornerRadius: CGFloat = 32
        static let buttonSize: CGFloat = 64
    }
    
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
        characterImageView.leadingToSuperview(offset: Constants.standardOffset)
        characterImageView.centerYToSuperview()
        
        nameLabel.top(to: characterImageView, offset: Constants.smallerOffset)
        nameLabel.leadingToTrailing(of: characterImageView, offset: Constants.standardOffset)
        nameLabel.trailingToSuperview(offset: Constants.standardOffset)
        
        descriptionLabel.topToBottom(of: nameLabel, offset: Constants.smallerOffset)
        descriptionLabel.leadingToTrailing(of: characterImageView, offset: Constants.standardOffset)
        descriptionLabel.trailingToSuperview(offset: Constants.standardOffset)
    }
    
    private func setupSubviews() {
        characterImageView.size(CGSize(width: Constants.buttonSize, height: Constants.buttonSize))
        characterImageView.layer.cornerRadius = Constants.cornerRadius
        
        nameLabel.font = .boldSystemFont(ofSize: Constants.standardOffset)
        
        descriptionLabel.font = .systemFont(ofSize: Constants.descriptionFont)
        descriptionLabel.textColor = .darkGray
    }
}
