//
//  EventDetailViewModel.swift
//  Teste
//
//  Created by Max Mendes on 16/04/20.
//  Copyright © 2020 Max Mendes. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class EventDetailViewModel {
    
    var dataSource: Event?
    var userEmailMock: String?
    var userNameMock: String?
    
    func getEventsById(id: String, completion:@escaping (Event?) -> Void){
         
         let url = API.baseUrl + Endpoints.events.rawValue + "/\(id)"
         
         EventService.getEventsById(url: url) { (result) in
             
             guard let event = result else{
                 print("Get event failed!")
                 completion(nil)
                 return
             }
             
             self.dataSource = event
             
             if let dataSource = self.dataSource{
                 completion(dataSource)
             }
         }
     }
    
    
    func checkIn(vc: EventDetailViewController?){
        
        var params = Parameters()
        var header = HTTPHeaders()
        
        userNameMock = "Max Mendes"
        userEmailMock = "maxmendes@teste.com"
        
        params["eventId"] = dataSource?.id ?? ""
        params["name"] = userNameMock
        params["email"] = userEmailMock
        
        
        let url = API.baseUrl + Endpoints.checkin.rawValue
        
        EventService.checkin(url: url, params: params, header: header, encoding: URLEncoding.httpBody) { (completion) in
            
            if completion{
                print("Checkin ok!")
                let confirmAlert = UIAlertController(title: "Parabéns", message: "Sua presença foi confirmada neste evento!", preferredStyle: UIAlertController.Style.alert)

                    confirmAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                         }))
                
                vc!.present(confirmAlert, animated: true, completion: nil)

            }else{
                print("POST checkin error!")
                let errorAlert = UIAlertController(title: "Parabéns", message: "Sua presença foi confirmada neste evento!", preferredStyle: UIAlertController.Style.alert)

                                 errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                                      }))
                
                vc!.present(errorAlert, animated: true, completion: nil)
            }
        }
    }
}
