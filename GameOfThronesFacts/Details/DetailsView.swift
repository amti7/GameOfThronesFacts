//
//  DetailsView.swift
//  GameOfThronesFactsApp
//
//  Created by Kamil on 27/09/2020.
//  Copyright © 2020 Kamil Gacek. All rights reserved.
//

import UIKit
import LBTAComponents
import TinyConstraints

protocol DetailsViewDelegate: AnyObject {
    func detailsViewShowMoreTapped(_ view: DetailsView)
}

final class DetailsView: BaseView {
    
    weak var delegate: DetailsViewDelegate?
    
    private struct Constants {
        static let doubleLine = 2
        static let standardOffset: CGFloat = 16
        static let biggerOffset: CGFloat = 32
        static let buttonHeight: CGFloat = 50
        static let standardImageSize: CGFloat = 56
        static let imageViewWidth: CGFloat = 400
        static let normalFontSize: CGFloat = 24
        static let bigFontSize: CGFloat = 50
        static let standardCornerRadius: CGFloat = 20
        static let moreString = "More details"
    }
        
    private let avatarImageView = CachedImageView()
    private let titleLabel = UILabel()
    private let detailsTextView = UITextView()
    private let moreButton = UIButton()
    
    override init() {
        super.init()
    }
    
    override func addSubviews() {
        [avatarImageView, titleLabel, detailsTextView, moreButton].forEach {
            addSubview($0)
        }
    }
    
    override func setupConstraints() {
        avatarImageView.leadingToSuperview()
        avatarImageView.trailingToSuperview()
        avatarImageView.topToSuperview()
        avatarImageView.height(Constants.imageViewWidth)
        
        titleLabel.leadingToSuperview(offset: Constants.standardOffset)
        titleLabel.trailingToSuperview(offset: Constants.standardOffset)
        titleLabel.topToBottom(of: avatarImageView, offset: Constants.biggerOffset)
        
        detailsTextView.topToBottom(of: titleLabel, offset: Constants.biggerOffset)
        detailsTextView.leadingToSuperview(offset: Constants.biggerOffset)
        detailsTextView.trailingToSuperview(offset: Constants.biggerOffset)
        
        moreButton.topToBottom(of: detailsTextView, offset: Constants.standardOffset)
        moreButton.leadingToSuperview(offset: Constants.biggerOffset)
        moreButton.trailingToSuperview(offset: Constants.biggerOffset)
        moreButton.height(Constants.buttonHeight)
        moreButton.bottomToSuperview(offset: -Constants.biggerOffset)
    }
    
    override func setupSubviews() {
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: Constants.bigFontSize)
        titleLabel.numberOfLines = Constants.doubleLine
        
        detailsTextView.font = .systemFont(ofSize: Constants.normalFontSize)
        detailsTextView.isEditable = false
                
        moreButton.backgroundColor = .systemYellow
        moreButton.setTitle(Constants.moreString, for: .normal)
        moreButton.setTitleColor(.black, for: .normal)
        moreButton.layer.cornerRadius = Constants.standardCornerRadius
        moreButton.addTarget(self, action: #selector(showMoreAction), for: .touchUpInside)
        
        backgroundColor = .white
    }
    
    func configureView(character: Character) {
        
        avatarImageView.loadImage(urlString: character.thumbnail)
        titleLabel.text = character.title
        detailsTextView.text = character.abstract
    }
    
    @objc private func showMoreAction() {
        delegate?.detailsViewShowMoreTapped(self)
    }
}
