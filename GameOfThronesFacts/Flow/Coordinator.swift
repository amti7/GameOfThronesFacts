//
//  Coordinator.swift
//  GameOfThronesFactsApp
//
//  Created by Kamil on 03/10/2020.
//  Copyright © 2020 Kamil Gacek. All rights reserved.
//

import UIKit

protocol Coordinator {
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

