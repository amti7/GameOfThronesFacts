//
//  BaseView.swift
//  GameOfThronesFactsApp
//
//  Created by Kamil on 27/09/2020.
//  Copyright © 2020 Kamil Gacek. All rights reserved.
//

import UIKit

class BaseView: UIView {

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupSubviews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func addSubviews() {}

    func setupConstraints() {}

    func setupSubviews() {}
}
