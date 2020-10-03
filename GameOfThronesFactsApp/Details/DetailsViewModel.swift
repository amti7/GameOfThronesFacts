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
    
    var characterString = "Ned Stark"
    var isFavorite: Bool?
    
    init(character: Character) {
        self.character = character
    }
    
    @objc func openMoreInSafariAction() {
        let urlStrign = provideUrlWhenButtonClicked()
        if let url = URL(string: urlStrign) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func provideUrlWhenButtonClicked() -> String {
        let name = characterString.replacingOccurrences(of: " ", with: "_")
        return "https://gameofthrones.wikia.com/wiki/\(String(describing: name))"
    }
}
