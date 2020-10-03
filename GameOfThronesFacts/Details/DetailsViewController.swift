//
//  DetailsViewController.swift
//  GameOfThronesFactsApp
//
//  Created by Kamil on 27/09/2020.
//  Copyright © 2020 Kamil Gacek. All rights reserved.
//

import UIKit
import LBTAComponents

class DetailsViewController: BaseViewController {
    
    private lazy var detailsView = DetailsView()
    private var viewModel: DetailsViewModelType
    
    override func loadView() {
        view = detailsView
    }
    
    init(viewModel: DetailsViewModelType) {
        self.viewModel = viewModel
        super.init()

        detailsView.delegate = self
    }
    
    override func viewDidLoad() {
        detailsView.configureView(character: viewModel.character)
    }
}

extension DetailsViewController: DetailsViewDelegate {
    func detailsViewShowMoreTapped(_ view: DetailsView) {
        viewModel.openMoreInSafariAction()
    }
}
