//
//  ViewController.swift
//  Teste
//
//  Created by Max Mendes on 15/04/20.
//  Copyright © 2020 Max Mendes. All rights reserved.
//

import UIKit
import Kingfisher

class EventsViewController: UIViewController {
    
    var dataSource:[Event] = []
    var viewModel: EventsViewModel?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loaderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModel()
    }
    
    func setViewModel(){
        self.viewModel = EventsViewModel()
        self.viewModel?.getEvents(completion: { (events) in
            self.loaderView.isHidden = true
            self.dataSource = events!
            self.collectionView.reloadData()
        })
        
    }
}

extension EventsViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems = self.viewModel?.dataSourceSize()
        return numberOfItems!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellEvent", for: indexPath) as! EventCollectionViewCell
        
        
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 0.8
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        
        let url = URL(string: dataSource[indexPath.row].image ?? "")
        cell.eventImage.kf.indicatorType = .activity
        cell.eventImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        
        cell.lblEventTitle.text = dataSource[indexPath.row].title
        cell.lblEventPrice.text = "Valor: R$ \(dataSource[indexPath.row].price ?? 0.0)"
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "EventDetailViewController") as! EventDetailViewController
        
        detailVC.id = dataSource[indexPath.row].id ?? ""
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

