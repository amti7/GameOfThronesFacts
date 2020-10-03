//
//  MainCoordinator.swift
//  GameOfThronesFactsApp
//
//  Created by Kamil on 03/10/2020.
//  Copyright © 2020 Kamil Gacek. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = CharacterListViewModel()
        let characterListViewController = CharacterListViewController(viewModel: viewModel)
        
        characterListViewController.handleCharacterSelected = { [weak self] character in
            self?.presentDetails(character: character)
        }
    navigationController.pushViewController(characterListViewController, animated: true)
    }
    
    private func presentDetails(character: Character) {
        let detailsViewModel = DetailsViewModel(character: character)
        let detailsViewController = DetailsViewController(viewModel: detailsViewModel)
        
        navigationController.present(detailsViewController, animated: true)
    }
    
}


