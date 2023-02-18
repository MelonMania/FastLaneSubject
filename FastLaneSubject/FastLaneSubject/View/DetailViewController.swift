//
//  DetailViewController.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/18.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    var event : ViewEvent?
    
    @IBOutlet weak var thumnailImageView: UIImageView!

    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!

    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setUI()
    }

    private func setUI() {
        if let eve = event {
            thumnailImageView.kf.setImage(with: URL(string: eve.eventImageURL), placeholder: UIImage(named: "DefaultEventImage"))
            customerNameLabel.text = eve.customerName
            locationNameLabel.text = eve.locationName
            nameLabel.text = eve.eventName
            commentLabel.text = eve.comment
            rateLabel.text = "\(eve.rate)"
            priceLabel.text = "\(eve.price)"
        }
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
    }
}
