//
//  EventService.swift
//  Teste
//
//  Created by Max Mendes on 15/04/20.
//  Copyright © 2020 Max Mendes. All rights reserved.
//

import Foundation
import Alamofire

struct EventService {
    
    static func getEvents(url: String, completion:@escaping (_ events: [Event]?) -> Void){
        
        AF.request(url, method: .get).responseJSON { (response) in            
            guard let data = response.data else{
                completion(nil)
                return
            }
            
            do{
                let result = try JSONDecoder().decode([Event].self, from: data)
                completion(result)
                
            }catch{
                completion(nil)
            }
        }
    }
    
    
    static func getEventsById(url: String, completion:@escaping (_ events: Event?) -> Void){
        
        AF.request(url, method: .get).responseJSON { (response) in
            guard let data = response.data else{
                completion(nil)
                return
            }
            
            do{
                let result = try JSONDecoder().decode(Event.self, from: data)
                completion(result)
                
            }catch{
                completion(nil)
            }
        }
    }
    
    static func checkin(url: String, params: Parameters, header: HTTPHeaders, encoding: ParameterEncoding, completion:@escaping (Bool) -> ()){
        
        AF.request(url, method: .post, parameters: params, encoding: encoding, headers: header).responseJSON { (response) in
            
            if response.response?.statusCode == 201 || response.response?.statusCode == 201{
                completion(true)
            }else{
                completion(false)
            }
        }
        
    }
}
