//
//  DetailsViewModel.swift
//  GameOfThronesFactsApp
//
//  Created by Kamil on 28/09/2020.
//  Copyright © 2020 Kamil Gacek. All rights reserved.
//

import UIKit

protocol DetailsViewModelType {
    var character: Character { get }
    
    func openMoreInSafariAction()
}

class DetailsViewModel: DetailsViewModelType {
    
    var character: Character
    var isFavorite: Bool?
    
    init(character: Character) {
        self.character = character
    }
    
    @objc func openMoreInSafariAction() {
        let urlString = urlFromString()
        if let url = URL(string: urlString) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func urlFromString() -> String {
        let name = character.title.replacingOccurrences(of: " ", with: "_")
        return "https://gameofthrones.wikia.com/wiki/\(String(describing: name))"
    }
}
