//
//  JsonStructuresAndClasses.swift
//  GameOfThronesFactsApp
//
//  Created by Kamil Gacek on 28.08.2018.
//  Copyright © 2018 Kamil Gacek. All rights reserved.
//

struct WebsiteDescription: Decodable {
    var basepath: String
    var items: [Character]
}
