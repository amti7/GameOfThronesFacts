//
//  ViewController.swift
//  GameOfThronesFactsApp
//
//  Created by Kamil Gacek on 15.08.2018.
//  Copyright © 2018 Kamil Gacek. All rights reserved.
//

import UIKit
import LBTAComponents


class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    private var areBookmarksEnabled = false
    
    var arrayOfComplexCharacters: [ComplexCharacter] = []
    var filteredArray: [ComplexCharacter] = []
    var selectedArray: [ComplexCharacter] = []
    var cachedImagesArray: [CachedImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        let wikiURL = "https://gameofthrones.wikia.com/api/v1/Articles/Top?expand=1&category=Articles&limit=65"
        getWikiFrom(urlString: wikiURL)
        provideNavigationBar()
    }
    
    func setupCollectionView() {
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(CharacterCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if areBookmarksEnabled {
            filteredArray = arrayOfComplexCharacters.filter { $0.isfavoriteImg }
            return filteredArray.count
        } else {
            return arrayOfComplexCharacters.count
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CharacterCell
        collectionView.isUserInteractionEnabled = true
        cell.isUserInteractionEnabled = true

        if areBookmarksEnabled {
            selectedArray = filteredArray
            cell.favoriteButton.setImage(#imageLiteral(resourceName: "addedToFavorites"), for: .normal)
        } else {
            selectedArray = arrayOfComplexCharacters
            cell.favoriteButton.index = indexPath.row
            if selectedArray[indexPath.row].isfavoriteImg {
                cell.favoriteButton.setImage(#imageLiteral(resourceName: "addedToFavorites"), for: .normal)
            } else {
                cell.favoriteButton.setImage(#imageLiteral(resourceName: "addToFavorites"), for: .normal)
            }
            cell.favoriteButton.addTarget(self, action: #selector(addCharacterToFavorites(sender:)), for: UIControlEvents.touchUpInside)
        }
        cell.characterTitle.text = selectedArray[indexPath.row].character.title
        cell.characterDetail.text = selectedArray[indexPath.row].character.abstract
        
        cell.characterImageView.loadImage(urlString: selectedArray[indexPath.row].character.thumbnail)
        
        return cell
    }
    
    @objc func addCharacterToFavorites(sender: FavoriteButton) {
        if !areBookmarksEnabled {
            if let index = sender.index {
                arrayOfComplexCharacters[index].isfavoriteImg = !arrayOfComplexCharacters[index].isfavoriteImg
                self.collectionView?.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        let controller = DetailViewController()
        controller.character = selectedArray[indexPath.row].character
        controller.characterImageView.loadImage(urlString: selectedArray[indexPath.row].character.thumbnail)
        controller.isFavorite = selectedArray[indexPath.row].isfavoriteImg
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func getWikiFrom(urlString: String){
        guard let url = URL(string: urlString) else { return  }
        
        
        
        URLSession.shared.dataTask(with: url) { [unowned self] data, response, error  in
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                do {
                    let description = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                    for item in description.items {
                        self.arrayOfComplexCharacters.append(ComplexCharacter(character: item, isfavoriteImg: false))
                    }
                } catch let jsonErr {
                    print("Error while decoding json: \(jsonErr)")
                }
                if let collection = self.collectionView {
                collection.reloadData()
                }
            }
        }.resume()
    }
    
    func provideNavigationBar() {
        
        navigationItem.title = "Game Of Thrones Wiki"
        let favoritesRightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.bookmarks, target: self, action: #selector(pressedFavoriteBookmarks(sender:)))
        navigationItem.rightBarButtonItem = favoritesRightButton
    }
    
    @objc func pressedFavoriteBookmarks(sender: Any) {
        areBookmarksEnabled = !areBookmarksEnabled
        self.collectionView?.reloadData()
    }
  
}