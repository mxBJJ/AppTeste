//
//  EventDetailViewController.swift
//  Teste
//
//  Created by Max Mendes on 16/04/20.
//  Copyright © 2020 Max Mendes. All rights reserved.
//

import Foundation
import UIKit
import LinkPresentation


class EventDetailViewController: UIViewController{
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var textFieldDescription: UITextView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var loaderView: UIView!
    
    var dataSource: Event?
    var viewModel: EventDetailViewModel?
    var id: String?
    
    
    override func viewDidLoad() {
        setViewModel()
    }
    
    func setViewModel(){
        self.viewModel = EventDetailViewModel()
        self.viewModel?.getEventsById(id: id!, completion: { (events) in
            self.loaderView.isHidden = true
            self.dataSource = events
            self.setDataInViews()
        })
    }
    
    
    func setDataInViews(){
        let url = URL(string: self.dataSource?.image ?? "")
        self.eventImage.kf.indicatorType = .activity
        self.eventImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        
        self.textFieldDescription.text = dataSource?.description ?? ""
        self.lblPrice.text = "Valor: R$ \(self.dataSource?.price ?? 0.0)"
    }
    
    func openAlertCheckIn(){
           
        let eventAlert = UIAlertController(title: "Fazer check-in", message: "Você deseja confirmar sua presença neste evento?", preferredStyle: UIAlertController.Style.alert)

           eventAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.viewModel?.checkIn(vc: self)
           }))

           eventAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
           }))

           present(eventAlert, animated: true, completion: nil)
       }
    
    func shareEvent(){
        
        let imageUrl = URL(string: dataSource?.image ?? "")
        
        let activityVC = UIActivityViewController(activityItems: [imageUrl!,  "\n " + (self.textFieldDescription.text)], applicationActivities: nil)
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    @IBAction func goToMap(_ sender: Any) {
        let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "EventMapViewController") as! EventMapViewController
            
        mapVC.latitude = dataSource?.latitude ?? 0.0
        mapVC.longitude = dataSource?.longitude ?? 0.0
        mapVC.eventName = dataSource?.title ?? ""
        
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @IBAction func goToCheckIn(_ sender: Any) {
        openAlertCheckIn()
    }
    
    @IBAction func share(_ sender: Any) {
        shareEvent()
    }
    
}
