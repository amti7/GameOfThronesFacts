//
//  CharacterListViewModel.swift
//  GameOfThronesFactsApp
//
//  Created by Kamil on 02/10/2020.
//  Copyright © 2020 Kamil Gacek. All rights reserved.
//

import Foundation

protocol CharacterListViewModelDelegate: AnyObject {
    func viewModelDataFetched(_ viewModel: CharacterListViewModelType)
}

protocol CharacterListViewModelType {
    var delegate: CharacterListViewModelDelegate? { get set }
    var characters: [Character] { get }
    
    func fetchCharaters()
}

class CharacterListViewModel: CharacterListViewModelType {
    
    var characters: [Character] = []
    weak var delegate: CharacterListViewModelDelegate?
    
    func fetchCharaters() {
        DataFetcher.shared.fetchCharacters { [weak self] characters, error in
            guard let self = self, let characters = characters else { return }
            
            self.characters = characters
            self.delegate?.viewModelDataFetched(self)
        }
    }
}
