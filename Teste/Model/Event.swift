//
//  Event.swift
//  Teste
//
//  Created by Max Mendes on 15/04/20.
//  Copyright © 2020 Max Mendes. All rights reserved.
//

import Foundation

struct Event: Codable{
    var people:[User]?
    var date: Int?
    var description:String?
    var image:String?
    var longitude:Double?
    var latitude:Double?
    var price:Double?
    var title:String?
    var id:String?
    var cupons: [Coupon]?
    
}
