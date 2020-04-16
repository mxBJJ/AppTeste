//
//  API.swift
//  Teste
//
//  Created by Max Mendes on 15/04/20.
//  Copyright © 2020 Max Mendes. All rights reserved.
//

import Foundation
extension Bundle {
    
    var api: String{
        return object(forInfoDictionaryKey: "api") as! String
    }
}

struct API {
    static let baseUrl = Bundle.main.api
}
