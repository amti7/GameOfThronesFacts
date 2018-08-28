//
//  CharacterCell.swift
//  GameOfThronesFactsApp
//
//  Created by Kamil Gacek on 28.08.2018.
//  Copyright © 2018 Kamil Gacek. All rights reserved.
//

import UIKit
import LBTAComponents

class CharacterCell: BaseClass {
    
    let characterImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    let characterTitle: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        return nameLabel
    }()
    
    
    let characterDetail: UILabel = {
        let detailLabel = UILabel()
        detailLabel.textColor = UIColor.darkGray
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        return detailLabel
    }()
    
    let favoriteButton: FavoriteButton = {
        let favoriteButton = FavoriteButton()
        
        return favoriteButton
    }()
    
    let containerView = UIView()
    var c: [NSLayoutConstraint]?
    var constraintToDelete: [NSLayoutConstraint]?
    
    override func setupViews(){
        
        addSubview(characterImageView)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat(format: "H:|-12-[v0(68)]", views: characterImageView)
        addConstraintsWithFormat(format: "V:[v0(68)]", views: characterImageView)
        addConstraints([NSLayoutConstraint(item: characterImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        
        addConstraintsWithFormat(format: "H:|-82-[v0]|", views: dividerLineView)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: dividerLineView)
        
        setupContainerView()
    }
    
    private func setupContainerView() {
        containerView.isUserInteractionEnabled = true
        addSubview(containerView)
        
        addConstraintsWithFormat(format: "H:|-100-[v0]|", views: containerView)
        addConstraintsWithFormat(format: "V:[v0(60)]", views: containerView)
        addConstraints([NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        
        containerView.addSubview(characterTitle)
        containerView.addSubview(characterDetail)
        containerView.addSubview(favoriteButton)
        
        containerView.addConstraintsWithFormat(format: "H:|[v0][v1(20)]-30-|", views: characterTitle,favoriteButton)
        
        c = NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0][v1(20)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": characterTitle,"v1": characterDetail])
        
        containerView.addConstraints(c!)
        containerView.addConstraintsWithFormat(format: "H:|[v0]-25-|", views: characterDetail)
        containerView.addConstraintsWithFormat(format: "V:|-10-[v0(20)]", views: favoriteButton)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        
        var viewsDictionary = [String:UIView]()
        for (index,view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

class BaseClass: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been impletmented")
    }
    
    func setupViews(){
        backgroundColor = UIColor.blue
    }
}
