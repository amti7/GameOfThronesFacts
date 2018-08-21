//
//  DetailViewController.swift
//  GameOfThronesFactsApp
//
//  Created by Kamil Gacek on 19.08.2018.
//  Copyright © 2018 Kamil Gacek. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var character: Character?
    var characterImage: UIImage?
    var isFavorite: Bool?
    
    let characterImageView: UIImageView = {
        let characterImageView = UIImageView()
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.layer.cornerRadius = 34
        characterImageView.layer.masksToBounds = true
        characterImageView.contentMode = .scaleAspectFit
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        return characterImageView
    }()
    
    let favoriteImage: UIImageView = {
        let favoriteImage = UIImageView()
        
        favoriteImage.translatesAutoresizingMaskIntoConstraints = false
        
        return favoriteImage
    }()

    
    let characterTitle: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    let characterTitleText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
        
    }()
    
    let characterDetail: UILabel = {
        let detailLabel = UILabel()
        detailLabel.font = UIFont.systemFont(ofSize: 18)
        detailLabel.textAlignment = .center
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        return detailLabel
    }()
    
    
    let checkOnlineButton: UIButton = {
        let checkButton = UIButton()
        checkButton.backgroundColor = UIColor.brown
        checkButton.layer.cornerRadius = 5
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        return checkButton
    }()
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(characterTitle)
        self.view.addSubview(characterDetail)
        self.view.addSubview(checkOnlineButton)
        
        characterImageView.image = characterImage
        checkOnlineButton.setTitle("Show more informations", for: .normal)
        checkOnlineButton.addTarget(self, action: #selector(openSafariAction), for: .touchUpInside)

        
        if let character = character {
            characterTitle.text = character.title
            characterDetail.text = character.abstract
        }
        
            setupLayout()
        }
    
    @objc func openSafariAction(sender: UIButton!) {
        let urlStringForUser = provideUrlWhenButtonClicked()
        UIApplication.shared.openURL(URL(string: urlStringForUser)!)
    }
    
    func provideUrlWhenButtonClicked() -> String {
        if let text = characterTitle.text {
            let name = text.replacingOccurrences(of: " ", with: "_")
            return "https://gameofthrones.wikia.com/wiki/\(String(describing: name))"
        }
        return ""
    }
    
    func setupLayout() {
        
        let topImageViewContainer = UIView()
        topImageViewContainer.backgroundColor = UIColor.white
        view.addSubview(topImageViewContainer)
        topImageViewContainer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        topImageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        
        topImageViewContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        topImageViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        topImageViewContainer.addSubview(characterImageView)
        characterImageView.centerXAnchor.constraint(equalTo: topImageViewContainer.centerXAnchor).isActive = true
        characterImageView.centerYAnchor.constraint(equalTo: topImageViewContainer.centerYAnchor).isActive = true
        characterImageView.heightAnchor.constraint(equalTo: topImageViewContainer.heightAnchor, multiplier: 0.5).isActive = true
        
        topImageViewContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        topImageViewContainer.addSubview(favoriteImage)
        if let favorite = isFavorite {
            if favorite {
                favoriteImage.image = #imageLiteral(resourceName: "addedToFavorites")
            } else {
                favoriteImage.image = #imageLiteral(resourceName: "addToFavorites")
            }
        }
        favoriteImage.centerXAnchor.constraint(equalTo: topImageViewContainer.centerXAnchor).isActive = true
        favoriteImage.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 20).isActive = true
    
        favoriteImage.heightAnchor.constraint(equalTo: topImageViewContainer.heightAnchor, multiplier: 0.1).isActive = true
        favoriteImage.widthAnchor.constraint(equalTo: topImageViewContainer.heightAnchor, multiplier: 0.1).isActive = true
  
        characterTitle.topAnchor.constraint(equalTo: topImageViewContainer.bottomAnchor, constant: 0).isActive = true
        characterTitle.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        characterTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        characterDetail.numberOfLines = 3
        characterDetail.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        characterDetail.topAnchor.constraint(equalTo: characterTitle.bottomAnchor, constant: 20).isActive = true
        characterDetail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        characterDetail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        checkOnlineButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        checkOnlineButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35).isActive = true
        checkOnlineButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        checkOnlineButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}

