//
//  EventCell.swift
//  StubhubTask
//
//  Created by Hesham Donia on 07/08/2022.
//

import UIKit

class EventCell: UITableViewCell {
    
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var event: Event! {
        didSet {
            artistNameLabel.text = event.name
            cityNameLabel.text = event.city
            priceLabel.text = "\(event.price ?? 0)$"
        }
    }
}
