//
//  EventsViewModel.swift
//  Teste
//
//  Created by Max Mendes on 15/04/20.
//  Copyright © 2020 Max Mendes. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Kingfisher

class EventsViewModel{
    
    var dataSource:[Event]?
    
    func getEvents(completion:@escaping ([Event]?) -> Void){
        
        let url = API.baseUrl + Endpoints.events.rawValue
        
        EventService.getEvents(url: url) { (result) in
            
            guard let events = result else{
                print("Get events failed!")
                completion(nil)
                return
            }
            
            self.dataSource = events
            
            if let dataSource = self.dataSource{
                completion(dataSource)
            }
        }
    }
    
    func dataSourceSize() -> Int{
        return dataSource?.count ?? 0
    }
}
