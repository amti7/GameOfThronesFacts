//
//  CharacterListViewController.swift
//  GameOfThronesFactsApp
//
//  Created by Kamil on 02/10/2020.
//  Copyright © 2020 Kamil Gacek. All rights reserved.
//

import UIKit
import TinyConstraints

final class CharacterListViewController: BaseViewController {
    
    var handleCharacterSelected: ((Character) -> Void)?
    
    private struct Constants {
        static let cell = "cell"
        static let cellHeight: CGFloat = 100
        static let title = "Game Of Thrones Wiki"
    }
    
    private var tableView = UITableView()
    private var viewModel: CharacterListViewModelType
    
    init(viewModel: CharacterListViewModelType) {
        self.viewModel = viewModel
        super.init()
        self.viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchCharaters()
    }
    
    override func addSubviews() {
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        tableView.edgesToSuperview()
    }
    
    override func setupSubviews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CharacterCell.self, forCellReuseIdentifier: Constants.cell)
    
        view.backgroundColor = .white
        navigationItem.title = Constants.title
        
    }
}

extension CharacterListViewController: UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell, for: indexPath) as? CharacterCell, viewModel.characters.indices.contains(indexPath.row) else { return UITableViewCell() }

        let character = viewModel.characters[indexPath.row]
        cell.configure(with: character)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }

}

extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleCharacterSelected?(viewModel.characters[indexPath.row])
    }
}

extension CharacterListViewController: CharacterListViewModelDelegate {
    func viewModelDataFetched(_ viewModel: CharacterListViewModelType) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
