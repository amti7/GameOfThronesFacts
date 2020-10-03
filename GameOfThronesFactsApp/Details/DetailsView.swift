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
        static let standardOffset: CGFloat = 16
        static let biggerOffset: CGFloat = 32
        static let buttonHeight: CGFloat = 50
        static let standardImageSize: CGFloat = 56
        static let imageViewWidth: CGFloat = 400
        static let bigFontSize: CGFloat = 35
        static let standardCornerRadius: CGFloat = 20
    }
        
    private let avatarImageView = CachedImageView()
    private let favouriteImage = UIImageView()
    private let titleLabel = UILabel()
    private let detailsView = UIView()
    private let moreButton = UIButton()
    
    override init() {
        super.init()
        backgroundColor = .white
    }
    
    override func addSubviews() {
        [avatarImageView, favouriteImage, titleLabel, detailsView, moreButton].forEach {
            addSubview($0)
        }
    }
    
    override func setupConstraints() {
        avatarImageView.leadingToSuperview()
        avatarImageView.trailingToSuperview()
        avatarImageView.topToSuperview()
        avatarImageView.height(Constants.imageViewWidth)
        
        favouriteImage.centerXToSuperview()
        favouriteImage.topToBottom(of: avatarImageView, offset: Constants.standardOffset)
        favouriteImage.width(Constants.standardImageSize)
        favouriteImage.height(Constants.standardImageSize)
        
        titleLabel.leadingToSuperview(offset: Constants.standardOffset)
        titleLabel.trailingToSuperview(offset: Constants.standardOffset)
        titleLabel.topToBottom(of: favouriteImage, offset: Constants.standardOffset)
        
        detailsView.topToBottom(of: titleLabel, offset: Constants.standardOffset)
        detailsView.leadingToSuperview(offset: Constants.standardOffset)
        detailsView.trailingToSuperview(offset: Constants.standardOffset)
        
        moreButton.topToBottom(of: detailsView, offset: Constants.standardOffset)
        moreButton.leadingToSuperview(offset: Constants.standardOffset)
        moreButton.trailingToSuperview(offset: Constants.standardOffset)
        moreButton.height(Constants.buttonHeight)
        moreButton.bottomToSuperview(offset: -Constants.biggerOffset)
    }
    
    override func setupSubviews() {
        avatarImageView.backgroundColor = .systemRed
        favouriteImage.backgroundColor = .systemGray
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: Constants.bigFontSize)
        
        detailsView.backgroundColor = .systemTeal
        
        moreButton.backgroundColor = .systemPink
        moreButton.setTitle("More details", for: .normal)
        moreButton.layer.cornerRadius = Constants.standardCornerRadius
        moreButton.addTarget(self, action: #selector(showMoreAction), for: .touchUpInside)
    }
    
    func configureView(character: Character) {
        
        avatarImageView.loadImage(urlString: character.thumbnail)
        titleLabel.text = character.title
        
    }
    
    @objc private func showMoreAction() {
        delegate?.detailsViewShowMoreTapped(self)
    }
}
