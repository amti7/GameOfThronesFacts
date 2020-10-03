//
//  Environment.swift
//  GameOfThronesFactsApp
//
//  Created by Kamil on 02/10/2020.
//  Copyright © 2020 Kamil Gacek. All rights reserved.
//

import Foundation

struct Environment {
    
    private enum PlistKey: String {
        case server_scheme
        case server_host
    }
    
    private static var infoDict: [String: Any] {
        return Bundle.main.infoDictionary!
    }
    
    static var serverURL: URL {
        let scheme = infoDict[PlistKey.server_scheme.rawValue]! as! String
        let host = infoDict[PlistKey.server_host.rawValue]! as! String
        let components = NSURLComponents()
        components.scheme = scheme
        components.host = host
        return components.url!
    }
}
