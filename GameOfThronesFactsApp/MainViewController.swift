//
//  ViewController.swift
//  GameOfThronesFactsApp
//
//  Created by Kamil Gacek on 15.08.2018.
//  Copyright © 2018 Kamil Gacek. All rights reserved.
//

import UIKit


class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "cellId"
    private var areBookmarksEnabled = false
    
    var arrayOfComplexCharacters: [ComplexCharacter] = []
    var filteredArray: [ComplexCharacter] = []
    var selectedArray: [ComplexCharacter] = []
    
    var index: IndexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(CharacterCell.self, forCellWithReuseIdentifier: cellId)
        
        let wikiURL = "https://gameofthrones.wikia.com/api/v1/Articles/Top?expand=1&category=Articles&limit=65"
        getWikiFrom(urlString: wikiURL)
        provideNavigationBar()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if areBookmarksEnabled {
            filteredArray = arrayOfComplexCharacters.filter { $0.isfavoriteImg }
            return filteredArray.count
        } else {
            return arrayOfComplexCharacters.count
        }
        
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer)
    {
        if sender.state == .began {
             print("long press \(index.row)")
        }
       
        let cell = collectionView?.cellForItem(at: index) as! CharacterCell

        
        // cell.constraintToModify =
        // constraint jako zmienna
        // constant = 10
        UIView.animate(withDuration: 0.3, animations: {
            //constraint.constant = 20
            // cell.containerView.addConstraint()
            self.collectionView?.removeConstraints(cell.constraintToDelete!)
            // cell.containerView.removeConstraints(cell.constraintToDelete!)
            cell.characterDetail.numberOfLines = 2
            cell.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0][v1(40)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": cell.characterTitle,"v1": cell.characterDetail]))
            
            
             //containerView.addConstraintsWithFormat(format: "V:|[v0][v1(40)]|", views: characterTitle,characterDetail)
        })
        
        
       
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CharacterCell
        index = indexPath
        
        collectionView.isUserInteractionEnabled = true
        cell.isUserInteractionEnabled = true
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        cell.addGestureRecognizer(longPressRecognizer)
        
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
        cell.characterImageView.image = selectedArray[indexPath.row].profileImage
        
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
      
        let controller = DetailViewController()
        controller.character = selectedArray[indexPath.row].character
        controller.characterImage = selectedArray[indexPath.row].profileImage
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
                        self.arrayOfComplexCharacters.append(ComplexCharacter(character: item, profileImage: self.retrieveImageFrom(urlString: item.thumbnail), isfavoriteImg: false))
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
    
    func retrieveImageFrom(urlString: String) -> UIImage {
        if let url = URL(string: urlString) {
            let data = try? Data(contentsOf: url)
            
            if let imageData = data {
                if let image = UIImage(data: imageData) {
                    return image
                }
            }
        }
        return UIImage()
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

class FavoriteButton: UIButton {
    var index: Int?
}

struct WebsiteDescription: Decodable {
    var basepath: String
    var items: [Character]
}

struct Character: Decodable {
    var title: String
    var abstract: String
    var thumbnail: String
}

struct ComplexCharacter {
    var character: Character
    var profileImage: UIImage
    var isfavoriteImg: Bool 

}

class CharacterCell: BaseClass {

    let characterImageView: UIImageView = {
        let imageView = UIImageView()
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
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0][v1(20)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": characterTitle,"v1": characterDetail]))
        constraintToDelete = NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0][v1(20)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": characterTitle,"v1": characterDetail])
        constraintToDelete?.removeAll()
        // containerView.constraints.
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
